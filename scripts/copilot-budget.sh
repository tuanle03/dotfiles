#!/usr/bin/env bash
# Monthly request-budget guard around the GitHub Copilot CLI.
# Copilot bills a limited number of premium requests per month (default cap 200).
# This wrapper counts invocations per calendar month and refuses once the cap is hit,
# so the copilot-rescue subagent can never silently blow the monthly quota.
#
# Usage:
#   copilot-budget.sh --status            # show usage this month, do not spend
#   copilot-budget.sh -p "..." [flags]    # record one request, then run copilot
#
# Env:
#   COPILOT_MONTHLY_CAP   override the cap (default 200)
set -euo pipefail

CAP="${COPILOT_MONTHLY_CAP:-200}"
DIR="$HOME/.copilot"
MONTH="$(date +%Y-%m)"
LOG="$DIR/usage-$MONTH.log"
mkdir -p "$DIR"

count() {
  if [[ -f "$LOG" ]]; then wc -l < "$LOG" | tr -d ' '; else echo 0; fi
}

COUNT="$(count)"

if [[ "${1:-}" == "--status" ]]; then
  echo "Copilot requests this month ($MONTH): $COUNT / $CAP"
  exit 0
fi

if (( COUNT >= CAP )); then
  echo "BLOCKED: Copilot monthly cap reached ($COUNT/$CAP for $MONTH). Refusing to spend another request. Route this to Codex or a Claude tier instead, or raise COPILOT_MONTHLY_CAP." >&2
  exit 3
fi

if (( COUNT >= CAP * 9 / 10 )); then
  echo "WARN: Copilot at $COUNT/$CAP requests this month — near the cap. Batch remaining work into single requests." >&2
fi

# Record the request before running (a premium request is spent on attempt).
date -u +"%Y-%m-%dT%H:%M:%SZ" >> "$LOG"
exec copilot "$@"
