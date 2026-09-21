# setup (new machine)

Anyone with access to the repo copies one script and runs it. The script:

1. clones the repo (default `~/contexts`, or fast-forwards an existing clone)
2. installs the repo's `CLAUDE.md` into `~/.claude/CLAUDE.md` as a managed block, replacing `{{CONTEXTS_DIR}}` with the clone path
   (content outside the block is kept, and the original file is backed up to `CLAUDE.md.bak.<time>`)
3. sets the git identity for the repo if it's missing, then installs the watchdog service

```bash
# macOS
bash bootstrap.sh [clone_dir]
```

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File bootstrap.ps1 [-Dest C:\path\to\contexts]
```

Scripts: `scripts/macos/bootstrap.sh`, `scripts/windows/bootstrap.ps1`.
You need permission to push to the repo; with SSH, `ssh -T git@github.com` must succeed.

## Adding a mapping

Edit the repo's `CLAUDE.md`, not `~/.claude/CLAUDE.md`. Write paths with the `{{CONTEXTS_DIR}}` prefix.
The watchdog pushes the change, and on every machine it pulls the change and re-renders `~/.claude/CLAUDE.md`.

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
