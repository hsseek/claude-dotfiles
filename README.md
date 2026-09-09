# Agent configurations

This repository is the version-controlled source for personal Claude Code and
Codex configuration shared across machines.

## Layout

- `claude/CLAUDE.md` — Claude Code global instructions
- `claude/agents/` — Claude Code custom agents
- `codex/AGENTS.md` — Codex instructions applied from the home directory
- `codex/agents/` — Codex custom agents
- `skills/` — shared Skills installed for both tools
- `sync.sh` — compares, installs, or captures the managed files

Runtime state, credentials, settings, session history, and caches stay outside
this repository.

## Workflow

Treat this repository as the canonical copy. After editing it, review and
install the files:

```sh
./sync.sh check
./sync.sh install
```

If you edited the live files under `~/.claude`, `~/.codex`, or `~/.agents`,
capture those changes before reviewing and committing them:

```sh
./sync.sh capture
git diff
./sync.sh validate
```

`capture` reads both tools' agents and global instructions, plus the shared
Skills from `~/.agents/skills`. `install` writes the shared Skills to both
tools' active Skill directories.

The repository retains its existing GitHub remote even though the checkout is
now named `agent-configs` locally.
