# setup (new machine)

For the copy-paste install commands and how to add a mapping, see the [root README](../README.md).
The install commands run `scripts/macos/bootstrap.sh` / `scripts/windows/bootstrap.ps1`.

# watchdog

Keeps this repo in sync automatically, every 30 seconds by default:

- upstream has new commits → `git pull --rebase`
- local files are changed, added, or deleted → `git add -A` → commit (`auto: sync from <host>`) → push
- if a pull conflicts, the rebase is aborted and the local commit is kept; the log records a `CONFLICT` line (resolve it by hand)

## macOS (launchd)

```bash
scripts/macos/install.sh        # optional argument: interval in seconds (default 30)
tail -f ~/Library/Logs/contexts-watchdog.log
scripts/macos/uninstall.sh
```

## Windows (Task Scheduler)

```powershell
powershell -ExecutionPolicy Bypass -File scripts\windows\install.ps1 -Interval 30
Get-Content "$env:LOCALAPPDATA\contexts-watchdog\watchdog.log" -Wait
powershell -ExecutionPolicy Bypass -File scripts\windows\uninstall.ps1
```

## Manual run once

```bash
scripts/watchdog.sh --once
```

Requirement: `git push` must work without prompting for a password (SSH key in ssh-agent/Keychain, or a credential helper).
