# Cost Routing Policy

Superpowers handles orchestration, parallelization, and workflow. This file covers only **cost routing** — where to send work to minimize Claude token spend.

## Off-budget executors (prefer first)

| Path | Cost | Cap |
|------|------|-----|
| `codex:codex-rescue` subagent | GPT-5 quota — zero Claude tokens | None practical |
| `copilot-rescue` subagent | Copilot premium quota — zero Claude tokens | **~200/month hard cap** |

### Codex — default executor

Any well-specified implementation, diagnosis, or root-cause task → `codex:codex-rescue`. Main thread pays only dispatch prompt + synthesized result, not the implementation itself.

> **gstack `/codex` skill ≠ `codex:codex-rescue` subagent.** `/codex` runs inline in main thread. The subagent runs isolated off-budget. Always use the subagent for cost savings; use `/codex` skill only when user explicitly types it.

### Copilot — metered, explicit-only

`copilot-rescue` is hard-capped at ~200 requests/month (`scripts/copilot-budget.sh` enforces this). Rules:
- Only when user explicitly requests Copilot, **or** multiple tasks are bundled into one dispatch
- Never fan out multiple `copilot-rescue` calls for related work — bundle them
- Check budget first: `bash scripts/copilot-budget.sh --status`
- Budget guard refuses past cap; do not bypass

## Claude tier routing (when off-budget unavailable)

| Task | Agent | Tier |
|------|-------|------|
| Implement well-specified change / bugfix | `coder` | Sonnet |
| Locate / explore / find files | `scout` | Haiku |
| Run tests / lint / build | `runner` | Haiku |
| Mechanical edits (rename, format, codemod) | `mechanic` | Haiku |
| Quick in-thread code review | `critic` | Opus |
| Large PR / cloud multi-agent review | gstack `/review` | cloud |

## Priority order

1. **Codex** (`codex:codex-rescue`) — off-budget, no cap
2. **Copilot** (`copilot-rescue`) — off-budget, metered; explicit/bundled only
3. **Cheapest Claude tier** — Haiku agents → Sonnet `coder`
4. **Main thread** — planning, design decisions, synthesis only
