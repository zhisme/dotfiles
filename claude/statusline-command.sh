#!/bin/bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')

dir="${cwd/#$HOME/~}"

branch=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -z "$branch" ]; then
    branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  fi
  if [ -n "$branch" ]; then
    if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
      branch="${branch}*"
    fi
  fi
fi

out="$dir"
[ -n "$branch" ] && out="$out ($branch)"
out="$out [$model]"

caveman_dir=$(jq -r '.plugins["caveman@caveman"][0].installPath // empty' "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/plugins/installed_plugins.json" 2>/dev/null)
caveman=""
[ -n "$caveman_dir" ] && caveman=$(bash "$caveman_dir/src/hooks/caveman-statusline.sh" 2>/dev/null)
[ -n "$caveman" ] && out="$out $caveman"

printf '%s' "$out"
