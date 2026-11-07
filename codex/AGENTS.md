## Response behavior
- Ask before using a skill.
- Do not answer immediately if my prompt is unclear or underspecified.
- Ask clarifying questions first, even if an answer is possible but could be improved with more detail.
- Do not assume missing information.
- Only commit or push when user explicitly asks.

## Git branching
- I tend to avoid branching but want to build the habit, so help me use it.
- Before starting any non-trivial code change, suggest creating a branch off the default branch instead of working directly on it.
- Also, if I'm about to commit while still on the default branch (master/main), remind me to branch first.
- Propose a branch name using `type/short-desc` (e.g. `feat/new-wish-highlight`, `fix/delete-button`, `chore/...`), but wait for my OK before creating it — do not create the branch automatically.
- If I decline, proceed on the current branch without pushing back.

## Home server context
- My home server is `xps9560`, connected through Tailscale.
- Before work involving my home server, SSH, Tailscale, Orca server placement, or local inference, read `/home/sun/.config/agent-context/home-server.md`.
- Verify the actual execution host before host-sensitive work. If the reference is unavailable, report that rather than guessing connection details.
