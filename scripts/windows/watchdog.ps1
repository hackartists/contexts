# contexts watchdog (Windows): keeps this repo in sync with its upstream.
#   - upstream changed        -> pull (rebase)
#   - local files changed/new -> commit & push
#
# Usage: powershell -ExecutionPolicy Bypass -File watchdog.ps1 [-Once] [-Interval 30] [-Branch main]
param(
  [switch]$Once,
  [int]$Interval = 30,
  [string]$Branch = "",
  [string]$RepoDir = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)

$LogFile = Join-Path $env:LOCALAPPDATA "contexts-watchdog\watchdog.log"
New-Item -ItemType Directory -Force -Path (Split-Path $LogFile) | Out-Null

function Log($msg) {
  $line = "{0} [watchdog] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
  Add-Content -Path $LogFile -Value $line
  Write-Host $line
}

function G {
  $out = & git -C $RepoDir @args 2>&1
  $script:GitOk = ($LASTEXITCODE -eq 0)
  return $out
}

function Test-InProgress {
  $gd = (G rev-parse --absolute-git-dir) | Select-Object -First 1
  return (Test-Path "$gd\rebase-merge") -or (Test-Path "$gd\rebase-apply") -or
         (Test-Path "$gd\MERGE_HEAD") -or (Test-Path "$gd\index.lock")
}

function Sync-Once {
  if (-not (Test-Path $RepoDir)) { Log "repo not found: $RepoDir"; return }
  if (Test-InProgress) { Log "rebase/merge/lock in progress; skipping"; return }

  $cur = G symbolic-ref --quiet --short HEAD
  if (-not $GitOk) { Log "detached HEAD; skipping"; return }
  if ($Branch -and $cur -ne $Branch) { Log "on '$cur', expected '$Branch'; skipping"; return }

  # 1. Commit local changes (modified, deleted, untracked-but-not-ignored).
  if (G status --porcelain) {
    G add -A | Out-Null
    $files = (G diff --cached --name-only | Select-Object -First 20) -join "`n"
    G commit -q -m "auto: sync from $env:COMPUTERNAME" -m $files | Out-Null
    if ($GitOk) { Log ("committed: " + ($files -replace "`n", " ")) }
    else { Log "commit failed (is git user.name/user.email set?)"; return }
  }

  # 2. Fetch upstream and integrate.
  $upstream = G rev-parse --abbrev-ref --symbolic-full-name "@{u}"
  if (-not $GitOk) { Log "no upstream for '$cur'; skipping fetch/push"; return }
  $remote = ($upstream -split "/")[0]
  G fetch -q $remote | Out-Null
  if (-not $GitOk) { Log "fetch failed"; return }

  $behind = [int](G rev-list --count "HEAD..@{u}")
  if ($behind -gt 0) {
    G pull -q --rebase | Out-Null
    if ($GitOk) { Log "pulled $behind commit(s) from $upstream" }
    else { G rebase --abort | Out-Null; Log "CONFLICT pulling $upstream; rebase aborted, manual resolution needed"; return }
  }

  # 3. Push local commits.
  $ahead = [int](G rev-list --count "@{u}..HEAD")
  if ($ahead -gt 0) {
    G push -q | Out-Null
    if ($GitOk) { Log "pushed $ahead commit(s) to $upstream" } else { Log "push failed" }
  }
}

# Keep ~/.claude/CLAUDE.md in step with the repo's CLAUDE.md (only if it was installed).
function Update-ClaudeMd {
  try {
    & (Join-Path $PSScriptRoot "install-claude-md.ps1") -IfManaged -RepoDir $RepoDir 6>&1 | ForEach-Object { Log $_ }
  } catch { Log "CLAUDE.md refresh failed: $_" }
}

if ($Once) { Sync-Once; Update-ClaudeMd; exit }

Log "started: repo=$RepoDir interval=${Interval}s"
while ($true) {
  try { Sync-Once } catch { Log "error: $_" }
  Update-ClaudeMd
  Start-Sleep -Seconds $Interval
}
