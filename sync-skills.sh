#!/usr/bin/env bash
set -euo pipefail

# The repo is wherever this script lives, so no editing is needed
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Where skills get linked. Override with: SKILLS_DIR=/some/path ./sync-skills.sh
TARGET="${SKILLS_DIR:-$HOME/.claude/skills}"

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

run() {
  if [ "$DRY_RUN" -eq 1 ]; then echo "  (dry run) $*"; else "$@"; fi
}

run mkdir -p "$TARGET"

# Link every skill folder that contains a SKILL.md
for dir in "$REPO"/*/; do
  dir="${dir%/}"
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || continue
  link="$TARGET/$name"

  if [ -L "$link" ]; then
    if [ "$(readlink "$link")" = "$dir" ]; then
      echo "ok:      $name"
    else
      run ln -sfn "$dir" "$link"
      echo "fixed:   $name"
    fi
  elif [ -e "$link" ]; then
    echo "SKIPPED: $name (a real file or folder is already there)"
  else
    run ln -s "$dir" "$link"
    echo "linked:  $name"
  fi
done

# Offer to remove links that point into this repo but whose skill is gone
for link in "$TARGET"/*; do
  [ -L "$link" ] || continue
  dest="$(readlink "$link")"
  case "$dest" in
    "$REPO"/*)
      if [ ! -f "$dest/SKILL.md" ]; then
        if [ "$DRY_RUN" -eq 1 ]; then
          echo "would ask to remove dangling link: $(basename "$link")"
        else
          read -r -p "Remove dangling link $(basename "$link")? [y/N] " ans
          if [ "$ans" = "y" ]; then
            rm "$link"
            echo "removed: $(basename "$link")"
          fi
        fi
      fi
      ;;
  esac
done