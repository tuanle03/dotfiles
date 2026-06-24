@RTK.md
@DELEGATION.md

## gstack

Use the `/browse` skill from gstack for all web browsing. Never use `mcp__claude-in-chrome__*` tools.

Available gstack skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review, /design-consultation, /design-shotgun, /design-html, /review, /ship, /land-and-deploy, /canary, /benchmark, /browse, /connect-chrome, /qa, /qa-only, /design-review, /setup-browser-cookies, /setup-deploy, /setup-gbrain, /retro, /investigate, /document-release, /document-generate, /codex, /cso, /autoplan, /plan-devex-review, /devex-review, /careful, /freeze, /guard, /unfreeze, /gstack-upgrade, /learn.

## Skill routing

When request matches, invoke via Skill tool before responding. When in doubt, invoke the skill.

| Trigger | Skill |
|---------|-------|
| Any URL / web browsing | `/browse` — mandatory, never `mcp__claude-in-chrome__*` |
| Ship / create PR / push branch | `/ship` |
| Deploy to production / staging | `/land-and-deploy` |
| Code review / pre-merge diff check (default) | `/review` (gstack cloud) |
| Quick in-thread code review (small diff, no PR) | `critic` agent (DELEGATION.md) |
| Full review pipeline (CEO + design + eng) | `/autoplan` |
| Bug / error — default when unsure | `/investigate` |
| Bug / error — confirmed pure code, no browser needed | `superpowers:systematic-debugging` |
| QA / verify feature works in browser | `/qa` or `/qa-only` |
| Product ideas / brainstorming | `/office-hours` |
| Strategy / scope / prioritization | `/plan-ceo-review` |
| Architecture / technical design | `/plan-eng-review` |
| Design review / UI polish | `/design-review` or `/design-consultation` |
| Write spec / author issue | `/spec` |
| Save session progress | `/context-save` |
| Resume previous session | `/context-restore` |
| Implementation task (coding) | `codex:codex-rescue` subagent (see DELEGATION.md) |
