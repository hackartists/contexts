#!/usr/bin/env bash
# contexts watchdog: keeps this repo in sync with its upstream.
#   - upstream changed        -> pull (rebase)
#   - local files changed/new -> commit & push
#
# Usage: watchdog.sh [--once]
# Env:   WATCHDOG_INTERVAL (sec, default 30), WATCHDOG_BRANCH (default: current branch)
set -uo pipefail

REPO_DIR="${WATCHDOG_REPO:-$(cd "$(dirname "$0")/.." && pwd)}"
INTERVAL="${WATCHDOG_INTERVAL:-30}"
HOST="$(scutil --get LocalHostName 2>/dev/null || hostname -s)"

log() { printf '%s [watchdog] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"; }
g() { git -C "$REPO_DIR" "$@"; }

in_progress() {
  local gd; gd="$(g rev-parse --git-dir)"
  [[ "$gd" != /* ]] && gd="$REPO_DIR/$gd"
  [[ -d "$gd/rebase-merge" || -d "$gd/rebase-apply" || -f "$gd/MERGE_HEAD" || -f "$gd/index.lock" ]]
}

sync_once() {
  cd "$REPO_DIR" || { log "repo not found: $REPO_DIR"; return 1; }

  if in_progress; then
    log "rebase/merge/lock in progress; skipping"
    return 0
  fi

  local branch; branch="$(g symbolic-ref --quiet --short HEAD)" || { log "detached HEAD; skipping"; return 0; }
  if [[ -n "${WATCHDOG_BRANCH:-}" && "$branch" != "$WATCHDOG_BRANCH" ]]; then
    log "on '$branch', expected '$WATCHDOG_BRANCH'; skipping"
    return 0
  fi

  # 1. Commit local changes (modified, deleted, untracked-but-not-ignored).
  if [[ -n "$(g status --porcelain)" ]]; then
    g add -A
    local files; files="$(g diff --cached --name-only | head -20)"
    if g commit -q -m "auto: sync from ${HOST}" -m "$files"; then
      log "committed: $(echo "$files" | tr '\n' ' ')"
    else
      log "commit failed (is git user.name/user.email set?)"
      return 1
    fi
  fi

  # 2. Fetch upstream and integrate.
  local upstream; upstream="$(g rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)" || {
    log "no upstream for '$branch'; skipping fetch/push"
    return 0
  }
  g fetch -q "${upstream%%/*}" || { log "fetch failed"; return 1; }

  local behind ahead
  behind="$(g rev-list --count "HEAD..@{u}")"
  if (( behind > 0 )); then
    if g pull -q --rebase; then
      log "pulled $behind commit(s) from $upstream"
    else
      g rebase --abort 2>/dev/null
      log "CONFLICT pulling $upstream; rebase aborted, manual resolution needed"
      return 1
    fi
  fi

  # 3. Push local commits.
  ahead="$(g rev-list --count "@{u}..HEAD")"
  if (( ahead > 0 )); then
    if g push -q; then log "pushed $ahead commit(s) to $upstream"; else log "push failed"; return 1; fi
  fi
}

# Keep ~/.claude/CLAUDE.md in step with the repo's CLAUDE.md (only if it was installed).
refresh_claude_md() {
  WATCHDOG_REPO="$REPO_DIR" bash "$REPO_DIR/scripts/install-claude-md.sh" --if-managed 2>&1 | while read -r l; do log "$l"; done
}

if [[ "${1:-}" == "--once" ]]; then
  sync_once; rc=$?
  refresh_claude_md
  exit $rc
fi

log "started: repo=$REPO_DIR interval=${INTERVAL}s"
while true; do
  sync_once
  refresh_claude_md
  sleep "$INTERVAL"
done
