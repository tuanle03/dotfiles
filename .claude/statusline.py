#!/usr/bin/env python3
"""
Claude Code statusline — compact 2-line display optimized for Claude Pro/Max.
Reads JSON from stdin (Claude Code statusLine contract).

Line 1: ╭─ 📁 <project>  🌿 <branch>  🤖 <model>  💸 $X.XX
Line 2: ╰─ 🧠 ctx XX% <bar>  ⏳ 5h XX% <bar> reset Xh  📅 7d XX% <bar> reset Xd
"""

import json
import os
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

# ── ANSI helpers ─────────────────────────────────────────────────────────────

RESET    = "\033[0m"
BOLD     = "\033[1m"
DIM      = "\033[2m"

BRED     = "\033[91m"
BGREEN   = "\033[92m"
BYELLOW  = "\033[93m"
BBLUE    = "\033[94m"
BMAGENTA = "\033[95m"
BCYAN    = "\033[96m"
BWHITE   = "\033[97m"

def c(color: str, text: str) -> str:
    return f"{color}{text}{RESET}"

def bold(text: str) -> str:
    return f"{BOLD}{text}{RESET}"

def dim(text: str) -> str:
    return f"{DIM}{text}{RESET}"

def pct_color(pct: float) -> str:
    """Green <60, yellow 60-84, red 85+."""
    if pct >= 85:
        return BRED
    elif pct >= 60:
        return BYELLOW
    return BGREEN

# ── Progress bar ──────────────────────────────────────────────────────────────

BAR_WIDTH = 8

def progress_bar(pct: float) -> str:
    """Return a colored 8-block Unicode progress bar."""
    filled = round(pct / 100 * BAR_WIDTH)
    filled = max(0, min(BAR_WIDTH, filled))
    bar = "█" * filled + "░" * (BAR_WIDTH - filled)
    return c(pct_color(pct), bar)

# ── Countdown formatter ───────────────────────────────────────────────────────

def parse_resets_at(resets_at) -> float | None:
    """
    Accept either a Unix epoch float/int or an ISO-8601 string.
    Returns Unix epoch float or None on failure.
    """
    if resets_at is None:
        return None
    if isinstance(resets_at, (int, float)):
        return float(resets_at)
    if isinstance(resets_at, str):
        try:
            # Python 3.7+ handles offset-aware ISO-8601 via fromisoformat
            # but older Pythons choke on "+07:00" suffixes; use a fallback.
            try:
                dt = datetime.fromisoformat(resets_at)
            except ValueError:
                # Strip sub-second precision if present, try again
                dt = datetime.fromisoformat(resets_at[:19])
            if dt.tzinfo is None:
                dt = dt.replace(tzinfo=timezone.utc)
            return dt.timestamp()
        except Exception:
            return None
    return None

def fmt_countdown(resets_at) -> str:
    """Format time-until-reset as XhYYm or Xd Xh."""
    epoch = parse_resets_at(resets_at)
    if epoch is None:
        return "N/A"
    now = time.time()
    delta = max(0, epoch - now)
    total_mins = int(delta // 60)
    hours, mins = divmod(total_mins, 60)
    days, hours = divmod(hours, 24)
    if days > 0:
        return f"{days}d{hours}h"
    return f"{hours}h{mins:02d}m"

# ── Cost extractor ────────────────────────────────────────────────────────────

def extract_cost(data: dict) -> str:
    """
    Cost may be:
      - a dict like {"total_cost_usd": 0.486, ...}  ← bug case
      - a bare float/int
      - absent entirely
    Always returns a display string like "$0.49" or "N/A".
    """
    raw = (
        data.get("cost")
        or data.get("session_cost")
        or data.get("total_cost_usd")
    )
    if raw is None:
        return "N/A"
    if isinstance(raw, dict):
        raw = raw.get("total_cost_usd")
    if raw is None:
        return "N/A"
    try:
        return f"${float(raw):.2f}"
    except (ValueError, TypeError):
        return "N/A"

# ── Git branch + dirty ────────────────────────────────────────────────────────

def git_info(cwd: str) -> str:
    """Return 'branch' or 'branch*' (dirty). Empty string on failure."""
    try:
        result = subprocess.run(
            ["git", "-C", cwd, "--no-optional-locks", "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True, text=True, timeout=2,
        )
        if result.returncode != 0:
            return ""
        branch = result.stdout.strip()

        dirty = subprocess.run(
            ["git", "-C", cwd, "--no-optional-locks", "status", "--porcelain"],
            capture_output=True, text=True, timeout=2,
        )
        marker = c(BYELLOW, "*") if dirty.stdout.strip() else ""
        return f"{branch}{marker}"
    except Exception:
        return ""

# ── Login detection ───────────────────────────────────────────────────────────

def is_fresh_login(grace_secs: float = 10.0) -> bool:
    """
    Check if credentials were just updated (fresh login/account switch).
    Returns True if .credentials.json was modified within grace_secs.
    """
    cred_path = Path.home() / ".claude" / ".credentials.json"
    if not cred_path.exists():
        return False
    try:
        mtime = cred_path.stat().st_mtime
        now = time.time()
        return (now - mtime) < grace_secs
    except Exception:
        return False

# ── Main ──────────────────────────────────────────────────────────────────────

def main() -> None:
    try:
        raw = sys.stdin.read()
        data = json.loads(raw) if raw.strip() else {}
    except Exception:
        data = {}

    # Detect fresh login (account switch, re-auth) — skip stale data during transition
    if is_fresh_login():
        print(dim("╭─") + " " + f"🔑 {dim('logging in...')}")
        print(dim("╰─") + " " + f"{dim('updating session data...')}")
        return

    # ── Extract fields ────────────────────────────────────────────────────────

    cwd = (
        data.get("workspace", {}).get("current_dir")
        or data.get("cwd")
        or os.getcwd()
    )
    project = os.path.basename(cwd.rstrip("/")) or cwd

    model_name = (
        data.get("model", {}).get("display_name")
        or data.get("model", {}).get("id")
        or "N/A"
    )

    # Context window
    ctx = data.get("context_window", {}) or {}
    ctx_used_pct = ctx.get("used_percentage")  # may be None

    # Rate limits
    rl      = data.get("rate_limits", {}) or {}
    five_h  = rl.get("five_hour",  {}) or {}
    seven_d = rl.get("seven_day",  {}) or {}

    five_pct   = five_h.get("used_percentage")
    five_reset = five_h.get("resets_at")
    seven_pct  = seven_d.get("used_percentage")
    seven_reset = seven_d.get("resets_at")

    cost_str = extract_cost(data)

    # ── Line 1: ╭─ 📁 project  🌿 branch  🤖 model  💸 $X.XX ─────────────────

    proj_part   = f"📁 {bold(c(BCYAN, project))}"

    branch = git_info(cwd)
    branch_part = f"  🌿 {bold(c(BGREEN, branch))}" if branch else ""

    model_part  = f"  🤖 {bold(c(BMAGENTA, model_name))}"

    if cost_str != "N/A":
        cost_part = f"  💸 {bold(c(BYELLOW, cost_str))}"
    else:
        cost_part = f"  💸 {dim('N/A')}"

    prefix1 = dim("╭─") + " "
    line1 = prefix1 + proj_part + branch_part + model_part + cost_part

    # ── Line 2: ╰─ 🧠 ctx  ⏳ 5h  📅 7d ──────────────────────────────────────

    # Context segment
    if ctx_used_pct is not None:
        pct_f = float(ctx_used_pct)
        ctx_seg = (
            f"🧠 {dim('ctx')} "
            f"{c(pct_color(pct_f), f'{pct_f:02.0f}%')} "
            f"{progress_bar(pct_f)}"
        )
    else:
        ctx_seg = f"🧠 {dim('ctx')} {dim('N/A')}"

    # 5-hour segment
    if five_pct is not None:
        p5 = float(five_pct)
        reset5 = fmt_countdown(five_reset)
        five_seg = (
            f"  ⏳ {dim('5h')} "
            f"{c(pct_color(p5), f'{p5:02.0f}%')} "
            f"{progress_bar(p5)} "
            f"{dim('reset')} {c(BCYAN, reset5)}"
        )
    else:
        five_seg = f"  ⏳ {dim('5h')} {dim('N/A')}"

    # 7-day segment
    if seven_pct is not None:
        p7 = float(seven_pct)
        reset7 = fmt_countdown(seven_reset)
        seven_seg = (
            f"  📅 {dim('7d')} "
            f"{c(pct_color(p7), f'{p7:02.0f}%')} "
            f"{progress_bar(p7)} "
            f"{dim('reset')} {c(BCYAN, reset7)}"
        )
    else:
        seven_seg = f"  📅 {dim('7d')} {dim('N/A')}"

    prefix2 = dim("╰─") + " "
    line2 = prefix2 + ctx_seg + five_seg + seven_seg

    print(line1)
    print(line2)


if __name__ == "__main__":
    main()
