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
tools' active Skill directories: `~/.agents/skills` for Codex and
`~/.claude/skills` for Claude Code. Skills are copied and compared as complete
folders, including supporting files such as `references/`, `scripts/`, and assets.

The repository retains its existing GitHub remote even though the checkout is
now named `agent-configs` locally.

## Private home server context

The full home server inventory stays outside Git. The private local snapshot is
`private/home-server.md`; its live location is
`~/.config/agent-context/home-server.md`.

- `./sync.sh capture` copies the live document into the ignored private snapshot.
- `./sync.sh install` restores the private snapshot to the live location.
- `./sync.sh check` compares the two when a private snapshot is available.
- `./sync.sh validate` also checks that private context is ignored and untracked.

Private copies use a directory mode of 700 and a file mode of 600. If the source
document is absent, syncing skips it and preserves any existing destination.
The script refuses to sync if `private/` or a file named `home-server.md` has
been staged or committed, or if the private snapshot is no longer ignored.

GitHub does not back up or transfer ignored files. On a new machine, transfer the
full document through a private channel to either of the locations above before
using the corresponding install/capture operation. Review global instruction
references for that machine's actual home directory; the current tracked
instructions contain server-specific absolute paths. OpenCode configuration is
not currently managed by this script.

Do not force-add private files. Ignore rules and sync validation reduce accidental
disclosure; they cannot prevent a separate Git command from overriding them.
The tracked global instructions and historical skill references still contain
some server names and paths, but the full device/address inventory stays private.
