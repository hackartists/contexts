#!/usr/bin/env bash
# Renders <repo>/CLAUDE.md into ~/.claude/CLAUDE.md as a managed block,
# replacing {{CONTEXTS_DIR}} with this clone's location.
#
# Usage: install-claude-md.sh [--if-managed]
#   --if-managed  only refresh an existing managed block (used by the watchdog)
set -euo pipefail

REPO_DIR="${WATCHDOG_REPO:-$(cd "$(dirname "$0")/.." && pwd)}"
TEMPLATE="$REPO_DIR/CLAUDE.md"
TARGET="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/CLAUDE.md"
BEGIN_PREFIX='<!-- BEGIN contexts'
END_LINE='<!-- END contexts -->'

[[ -f "$TEMPLATE" ]] || { echo "template not found: $TEMPLATE" >&2; exit 1; }

dir="$REPO_DIR"
[[ "$dir" == "$HOME"/* ]] && dir="~${dir#"$HOME"}"

shopt -u patsub_replacement 2>/dev/null || true  # bash 5.2: don't treat & in $dir specially
content="$(<"$TEMPLATE")"
content="${content//"{{CONTEXTS_DIR}}"/$dir}"

block="$(mktemp)"; new="$(mktemp)"
trap 'rm -f "$block" "$new"' EXIT
{
  echo "$BEGIN_PREFIX (managed; edit $dir/CLAUDE.md, not this block) -->"
  echo "$content"
  echo "$END_LINE"
} > "$block"

if [[ -f "$TARGET" ]] && grep -q "^$BEGIN_PREFIX" "$TARGET"; then
  awk -v begin="$BEGIN_PREFIX" -v end="$END_LINE" -v blockfile="$block" '
    index($0, begin) == 1 { while ((getline l < blockfile) > 0) print l; skip = 1; next }
    skip && $0 == end     { skip = 0; next }
    !skip                 { print }
  ' "$TARGET" > "$new"
elif [[ "${1:-}" == "--if-managed" ]]; then
  exit 0
else
  mkdir -p "$(dirname "$TARGET")"
  if [[ -s "$TARGET" ]]; then
    backup="$TARGET.bak.$(date +%Y%m%d%H%M%S)"
    cp "$TARGET" "$backup"
    echo "backed up existing $TARGET -> $backup"
    { cat "$TARGET"; echo; cat "$block"; } > "$new"
  else
    cp "$block" "$new"
  fi
fi

if ! cmp -s "$new" "$TARGET" 2>/dev/null; then
  cp "$new" "$TARGET"
  echo "updated $TARGET"
fi
