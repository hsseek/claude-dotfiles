#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
user_dir=${HOME:?HOME must be set}

claude_agents="bold-strategist.md practical-engineer.md prompt-architect.md skeptic.md"
codex_agents="bold-strategist.toml practical-engineer.toml prompt-architect.toml skeptic.toml"
skills="bold-suggestion engineering-issue-review orca-agent-prompt practical-planning prompt-architect skeptical-review"

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

copy_skill() {
  source_dir=$1
  target_dir=$2
  mkdir -p "$target_dir"
  cp -R "$source_dir/." "$target_dir/"
  printf '%s -> %s\n' "$source_dir" "$target_dir"
}

compare_skill() {
  tracked_dir=$1
  active_dir=$2
  if [ ! -d "$active_dir" ]; then
    printf 'MISSING %s\n' "$active_dir"
    return 1
  fi
  if diff -r "$tracked_dir" "$active_dir" >/dev/null; then
    printf 'OK      %s\n' "$active_dir"
  else
    printf 'DIFF    %s\n' "$active_dir"
    return 1
  fi
}

install_files() {
  copy_file "$repo_dir/claude/CLAUDE.md" "$user_dir/.claude/CLAUDE.md"
  copy_file "$repo_dir/codex/AGENTS.md" "$user_dir/.codex/AGENTS.md"
  for file in $claude_agents; do
    copy_file "$repo_dir/claude/agents/$file" "$user_dir/.claude/agents/$file"
  done
  for file in $codex_agents; do
    copy_file "$repo_dir/codex/agents/$file" "$user_dir/.codex/agents/$file"
  done
  for skill in $skills; do
    copy_skill "$repo_dir/skills/$skill" "$user_dir/.claude/skills/$skill"
    copy_skill "$repo_dir/skills/$skill" "$user_dir/.agents/skills/$skill"
  done
}

capture_files() {
  copy_file "$user_dir/.claude/CLAUDE.md" "$repo_dir/claude/CLAUDE.md"
  copy_file "$user_dir/.codex/AGENTS.md" "$repo_dir/codex/AGENTS.md"
  for file in $claude_agents; do
    copy_file "$user_dir/.claude/agents/$file" "$repo_dir/claude/agents/$file"
  done
  for file in $codex_agents; do
    copy_file "$user_dir/.codex/agents/$file" "$repo_dir/codex/agents/$file"
  done
  for skill in $skills; do
    copy_skill "$user_dir/.agents/skills/$skill" "$repo_dir/skills/$skill"
  done
}

check_files() {
  result=0
  compare_file "$repo_dir/claude/CLAUDE.md" "$user_dir/.claude/CLAUDE.md" || result=1
  compare_file "$repo_dir/codex/AGENTS.md" "$user_dir/.codex/AGENTS.md" || result=1
  for file in $claude_agents; do
    compare_file "$repo_dir/claude/agents/$file" "$user_dir/.claude/agents/$file" || result=1
  done
  for file in $codex_agents; do
    compare_file "$repo_dir/codex/agents/$file" "$user_dir/.codex/agents/$file" || result=1
  done
  for skill in $skills; do
    compare_skill "$repo_dir/skills/$skill" "$user_dir/.claude/skills/$skill" || result=1
    compare_skill "$repo_dir/skills/$skill" "$user_dir/.agents/skills/$skill" || result=1
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
