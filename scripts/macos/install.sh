#!/usr/bin/env bash
# Installs the contexts watchdog as a launchd user agent (starts at login, restarts if it dies).
# Usage: scripts/macos/install.sh [interval_seconds]
set -euo pipefail

LABEL="com.hackartists.contexts-watchdog"
REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPT="$REPO_DIR/scripts/watchdog.sh"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
LOG="$HOME/Library/Logs/contexts-watchdog.log"
INTERVAL="${1:-30}"

chmod +x "$SCRIPT"
mkdir -p "$(dirname "$PLIST")" "$(dirname "$LOG")"

cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$SCRIPT</string>
  </array>
  <key>WorkingDirectory</key><string>$REPO_DIR</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
    <key>WATCHDOG_INTERVAL</key><string>$INTERVAL</string>
  </dict>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>ThrottleInterval</key><integer>30</integer>
  <key>ProcessType</key><string>Background</string>
  <key>StandardOutPath</key><string>$LOG</string>
  <key>StandardErrorPath</key><string>$LOG</string>
</dict>
</plist>
PLIST

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"
launchctl enable "gui/$(id -u)/$LABEL"

echo "installed: $PLIST"
echo "log:       $LOG"
echo "status:    launchctl print gui/$(id -u)/$LABEL | grep -E 'state|pid'"
