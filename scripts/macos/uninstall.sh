#!/usr/bin/env bash
set -euo pipefail
LABEL="com.hackartists.contexts-watchdog"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
rm -f "$PLIST"
echo "uninstalled: $LABEL"
