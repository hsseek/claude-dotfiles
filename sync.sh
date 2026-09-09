#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
user_dir=${HOME:?HOME must be set}

claude_agents="bold-strategist.md practical-engineer.md prompt-architect.md skeptic.md"
codex_agents="bold-strategist.toml practical-engineer.toml prompt-architect.toml skeptic.toml"
skills="bold-suggestion engineering-issue-review practical-planning skeptical-review"

copy_file() {
  source_file=$1
  target_file=$2
  mkdir -p "$(dirname -- "$target_file")"
  cp "$source_file" "$target_file"
  printf '%s -> %s\n' "$source_file" "$target_file"
}

compare_file() {
  tracked_file=$1
  active_file=$2
  if [ ! -f "$active_file" ]; then
    printf 'MISSING %s\n' "$active_file"
    return 1
  fi
  if cmp -s "$tracked_file" "$active_file"; then
    printf 'OK      %s\n' "$active_file"
  else
    printf 'DIFF    %s\n' "$active_file"
    return 1
  fi
}

install_files() {
  copy_file "$repo_dir/claude/CLAUDE.md" "$user_dir/.claude/CLAUDE.md"
  copy_file "$repo_dir/codex/AGENTS.md" "$user_dir/AGENTS.md"
  for file in $claude_agents; do
    copy_file "$repo_dir/claude/agents/$file" "$user_dir/.claude/agents/$file"
  done
  for file in $codex_agents; do
    copy_file "$repo_dir/codex/agents/$file" "$user_dir/.codex/agents/$file"
  done
  for skill in $skills; do
    copy_file "$repo_dir/skills/$skill/SKILL.md" "$user_dir/.claude/skills/$skill/SKILL.md"
    copy_file "$repo_dir/skills/$skill/SKILL.md" "$user_dir/.agents/skills/$skill/SKILL.md"
  done
}

capture_files() {
  copy_file "$user_dir/.claude/CLAUDE.md" "$repo_dir/claude/CLAUDE.md"
  copy_file "$user_dir/AGENTS.md" "$repo_dir/codex/AGENTS.md"
  for file in $claude_agents; do
    copy_file "$user_dir/.claude/agents/$file" "$repo_dir/claude/agents/$file"
  done
  for file in $codex_agents; do
    copy_file "$user_dir/.codex/agents/$file" "$repo_dir/codex/agents/$file"
  done
  for skill in $skills; do
    copy_file "$user_dir/.agents/skills/$skill/SKILL.md" "$repo_dir/skills/$skill/SKILL.md"
  done
}

check_files() {
  result=0
  compare_file "$repo_dir/claude/CLAUDE.md" "$user_dir/.claude/CLAUDE.md" || result=1
  compare_file "$repo_dir/codex/AGENTS.md" "$user_dir/AGENTS.md" || result=1
  for file in $claude_agents; do
    compare_file "$repo_dir/claude/agents/$file" "$user_dir/.claude/agents/$file" || result=1
  done
  for file in $codex_agents; do
    compare_file "$repo_dir/codex/agents/$file" "$user_dir/.codex/agents/$file" || result=1
  done
  for skill in $skills; do
    compare_file "$repo_dir/skills/$skill/SKILL.md" "$user_dir/.claude/skills/$skill/SKILL.md" || result=1
    compare_file "$repo_dir/skills/$skill/SKILL.md" "$user_dir/.agents/skills/$skill/SKILL.md" || result=1
  done
  return "$result"
}

validate_files() {
  python3 -c 'import pathlib, sys, tomllib
files = sorted(pathlib.Path(sys.argv[1]).glob("*.toml"))
for path in files:
    data = tomllib.loads(path.read_text())
    missing = {"name", "description", "developer_instructions"} - data.keys()
    if missing:
        raise SystemExit(f"{path}: missing {sorted(missing)}")
    if data["name"] != path.stem:
        raise SystemExit(f"{path}: name does not match filename")
    print(f"VALID   {path}")' "$repo_dir/codex/agents"
}

case ${1:-} in
  install) install_files ;;
  capture) capture_files ;;
  check) check_files ;;
  validate) validate_files ;;
  *)
    printf 'Usage: %s {check|install|capture|validate}\n' "$0" >&2
    exit 2
    ;;
esac
