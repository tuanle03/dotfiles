# Delegation policy

Default to splitting work across model-tiered subagents instead of doing everything in the main thread. The main thread (Opus) owns planning, orchestration, and final synthesis; delegate execution down-tier. The user can always override ("do it yourself", "use Opus for this", "no subagents").

## Route by task type

Dispatch via the Agent tool (`subagent_type`):

| Task | Agent | Tier |
|------|-------|------|
| Locate / explore / "where is X" / map a module / gather relevant files | `scout` | Haiku, read-only |
| Run tests / lint / typecheck / build; reproduce a failure | `runner` | Haiku, read-only |
| Mechanical edits: rename, find/replace, format, import/comment cleanup, codemod | `mechanic` | Haiku |
| Implement a bounded, well-specified change / feature / bugfix | `coder` | Sonnet |
| Review a diff/branch before merge | `critic` (in-thread) **or** Codex (independent model) | Opus / GPT-5 |
| Stuck, want a 2nd implementation or diagnosis, or hand off a substantial coding task | `codex:codex-rescue` | Codex / GPT-5 |

## Rules

- **Cheapest sufficient tier.** Prefer the lowest tier that can do the job correctly. Escalate Haiku → Sonnet → Opus/Codex only when the lower tier is insufficient or returns low confidence.
- **Keep judgment central.** Planning and cross-cutting design decisions stay in the main thread. Delegate only well-scoped units; if a subagent hits a real fork, it reports back rather than guessing.
- **Parallelize.** Independent subagents go out in a single message so they run concurrently.
- **Codex is routed case-by-case** (review / rescue / implementation) through `codex:codex-rescue` or the `/codex:*` commands — my call per task, not a fixed rule. Codex gives a second model's perspective; use it for adversarial review and when a Claude pass is stuck or wants an independent attempt.
- **Synthesize, don't dump.** A subagent's final message is a tool result only the main thread sees — relay the conclusion to the user, not the raw transcript.
