#!/bin/bash
input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '(.cwd // .workspace.current_dir) // ""')
model=$(printf '%s' "$input" | jq -r '
  if (.model | type) == "object" then (.model.display_name // .model.name // .model.id // "")
  elif (.model | type) == "string" then .model
  else (.display_name // .model_name // "") end
')

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
[ -n "$model" ] && out="$out [$model]"

printf '%s' "$out"
