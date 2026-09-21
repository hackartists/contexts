#!/usr/bin/env bash
# One-shot setup for the contexts repo on macOS. Copy this file anywhere and run it:
#
#   bash bootstrap.sh [clone_dir]          # default clone_dir: ~/contexts
#
# It will:
#   1. clone the repo (or fast-forward an existing clone)
#   2. install the repo's CLAUDE.md into ~/.claude/CLAUDE.md (paths rewritten to clone_dir)
#   3. install the watchdog launchd agent (auto pull / commit / push)
#
# Env overrides: CONTEXTS_REPO_URL, CONTEXTS_DIR, WATCHDOG_INTERVAL, GIT_USER_NAME, GIT_USER_EMAIL
set -euo pipefail

REPO_URL="${CONTEXTS_REPO_URL:-git@github.com:hackartists/contexts.git}"
DEST="${1:-${CONTEXTS_DIR:-$HOME/contexts}}"
INTERVAL="${WATCHDOG_INTERVAL:-30}"

step() { printf '\n==> %s\n' "$*"; }
die()  { printf 'error: %s\n' "$*" >&2; exit 1; }
ask()  { local v; read -r -p "$1: " v < /dev/tty; echo "$v"; }

command -v git >/dev/null || die "git not found. Run: xcode-select --install"

step "Checking access to $REPO_URL"
git ls-remote -q "$REPO_URL" HEAD >/dev/null 2>&1 \
  || die "cannot access $REPO_URL. Check your GitHub permission and SSH key (ssh -T git@github.com)."

DEST="${DEST/#\~/$HOME}"
if [[ -d "$DEST/.git" ]]; then
  step "Updating existing clone at $DEST"
  git -C "$DEST" pull --ff-only
elif [[ -e "$DEST" && -n "$(ls -A "$DEST")" ]]; then
  die "$DEST exists and is not empty. Pass another directory: bash bootstrap.sh <dir>"
else
  step "Cloning into $DEST"
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO_URL" "$DEST"
fi
DEST="$(cd "$DEST" && pwd)"

step "Checking git identity (needed for auto-commits)"
if ! git -C "$DEST" config user.email >/dev/null; then
  name="${GIT_USER_NAME:-$(ask 'git user.name')}"
  email="${GIT_USER_EMAIL:-$(ask 'git user.email')}"
  [[ -n "$name" && -n "$email" ]] || die "git user.name/user.email are required"
  git -C "$DEST" config user.name "$name"
  git -C "$DEST" config user.email "$email"
  echo "set for this repo: $name <$email>"
else
  echo "using $(git -C "$DEST" config user.name) <$(git -C "$DEST" config user.email)>"
fi

step "Installing CLAUDE.md into ~/.claude/CLAUDE.md"
bash "$DEST/scripts/install-claude-md.sh"

step "Installing watchdog (launchd)"
bash "$DEST/scripts/macos/install.sh" "$INTERVAL"

step "Done"
echo "repo:      $DEST"
echo "claude:    ~/.claude/CLAUDE.md"
echo "watchdog:  tail -f ~/Library/Logs/contexts-watchdog.log"
