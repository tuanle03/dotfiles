# Delegation policy

Default to splitting work across model-tiered subagents instead of doing everything in the main thread. The main thread (Opus) owns planning, orchestration, and final synthesis; delegate execution down-tier. The user can always override ("do it yourself", "use Opus for this", "no subagents").

## Token strategy: push execution off the Opus budget

Every token the main thread spends *implementing* is an Opus token. Two levers move work off that budget:

1. **Codex first for execution.** Codex (`codex:codex-rescue`, `/codex:*`) runs on a separate GPT-5 quota — its work never touches the Claude context or usage. For any well-specified coding/execution task that does not need Opus-level judgment, hand it to Codex. Cheapest path available: the main thread pays only the dispatch prompt + the synthesized result, not the implementation.
2. **Copilot as a metered second off-budget executor.** `copilot-rescue` forwards to the GitHub Copilot CLI (off the Claude budget) but Copilot has a HARD monthly cap of ~200 premium requests, enforced by `scripts/copilot-budget.sh` (refuses past the cap). So it is NOT a silent auto-fallback: use it only when the user explicitly asks for Copilot, or when several Copilot-suitable tasks can be **bundled into one request** (one dispatch = one request — never split). Check remaining budget with `bash scripts/copilot-budget.sh --status`.
3. **Cheapest Claude tier otherwise.** Default fallback when Codex is unavailable, or for search/test/mechanical work, is the lowest Claude tier that does it correctly (Haiku → Sonnet) — never Opus for execution. Reach for Copilot only under the batched/explicit rule above.

## Route by task type

Dispatch via the Agent tool (`subagent_type`):

| Task | Route | Tier / cost |
|------|-------|-------------|
| Implement a well-specified change / feature / bugfix from a clear spec | **`codex:codex-rescue`** (default) → `coder` (Sonnet) if Codex unavailable. `copilot-rescue` only when explicitly requested or batching several tasks into one request (~200/mo cap) | GPT-5 (off budget) / Sonnet / metered Copilot |
| Stuck; want a 2nd implementation, diagnosis, or deep root-cause pass | `codex:codex-rescue` | GPT-5 (off budget) |
| Locate / explore / "where is X" / map a module / gather relevant files | `scout` | Haiku, read-only |
| Run tests / lint / typecheck / build; reproduce a failure | `runner` | Haiku, read-only |
| Mechanical edits: rename, find/replace, format, import/comment cleanup, codemod | `mechanic` | Haiku |
| Review a diff/branch before merge | `critic` (in-thread) **or** Codex (independent model) | Opus / GPT-5 |

## Rules

- **Codex is the default executor.** Well-specified implementation work goes to Codex unless it needs Opus-level reasoning or Codex is unavailable (not logged in / offline) — then fall back to `coder` (Sonnet). Resolve ambiguous specs or live design decisions in the main thread *first*, then dispatch a clean spec.
- **Copilot is metered, not a default.** `copilot-rescue` is hard-capped at ~200 requests/month. Only route to it when the user explicitly asks for Copilot, or when multiple Copilot-suitable tasks can be **gathered into a single dispatch** (one request total). Never fan out several copilot-rescue calls for related work — bundle them. The budget guard refuses once the cap is hit; do not bypass it.
- **Cheapest sufficient tier.** Prefer the lowest tier/cost that does the job correctly. Escalate Codex/Haiku → Sonnet → Opus only when the lower option is insufficient or returns low confidence.
- **Keep judgment central.** Planning and cross-cutting design decisions stay in the main thread. Delegate only well-scoped units; if a subagent hits a real fork, it reports back rather than guessing.
- **Parallelize.** Independent subagents go out in a single message so they run concurrently.
- **Synthesize, don't dump.** A subagent's final message is a tool result only the main thread sees — relay the conclusion to the user, not the raw transcript.
