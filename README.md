# contexts

Shared Claude Code context: per-repository `CLAUDE.md` files, mapped from `~/.claude/CLAUDE.md`.

## Install

You need push access to this repo. With SSH, `ssh -T git@github.com` must succeed.
Paste the command for your OS into a terminal.

### macOS (Terminal)

```bash
D="$HOME/contexts"; [ -d "$D/.git" ] || git clone git@github.com:hackartists/contexts.git "$D" && bash "$D/scripts/macos/bootstrap.sh" "$D"
```

### Windows (PowerShell)

```powershell
$D = "$HOME\contexts"; if (-not (Test-Path "$D\.git")) { git clone git@github.com:hackartists/contexts.git $D }; powershell -NoProfile -ExecutionPolicy Bypass -File "$D\scripts\windows\bootstrap.ps1" -Dest $D
```

To use another location, change `D` / `$D`. Running the command again is safe: it updates the clone and reinstalls.

The command:

1. clones this repo into `~/contexts`
2. installs this repo's `CLAUDE.md` into `~/.claude/CLAUDE.md` as a managed block, replacing `{{CONTEXTS_DIR}}` with the clone path
   (content outside the block is kept, and the original file is backed up to `CLAUDE.md.bak.<time>`)
3. asks for git `user.name` / `user.email` if they aren't set
4. installs the watchdog, which pulls, commits and pushes changes automatically (launchd on macOS, Task Scheduler on Windows)

If `~/.claude/CLAUDE.md` already contains a copy of the mapping table, delete it after installing so it isn't there twice.

## Adding a mapping

Edit this repo's `CLAUDE.md`, not `~/.claude/CLAUDE.md`, and write paths with the `{{CONTEXTS_DIR}}` prefix:

```markdown
| github.com/org/repo | {{CONTEXTS_DIR}}/repo/CLAUDE.md |
```

The watchdog pushes the change, and on every machine it pulls the change and re-renders `~/.claude/CLAUDE.md`.

## More

Watchdog logs, uninstalling and running by hand: [scripts/README.md](scripts/README.md).
