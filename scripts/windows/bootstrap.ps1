# One-shot setup for the contexts repo on Windows. Copy this file anywhere and run it:
#
#   powershell -ExecutionPolicy Bypass -File bootstrap.ps1 [-Dest C:\path\to\contexts]
#
# It will:
#   1. clone the repo (or fast-forward an existing clone)          default Dest: ~\contexts
#   2. install the repo's CLAUDE.md into ~\.claude\CLAUDE.md (paths rewritten to Dest)
#   3. install the watchdog Scheduled Task (auto pull / commit / push)
param(
  [string]$Dest = $(if ($env:CONTEXTS_DIR) { $env:CONTEXTS_DIR } else { Join-Path $HOME "contexts" }),
  [string]$RepoUrl = $(if ($env:CONTEXTS_REPO_URL) { $env:CONTEXTS_REPO_URL } else { "git@github.com:hackartists/contexts.git" }),
  [int]$Interval = 30
)

function Step($m) { Write-Host "`n==> $m" -ForegroundColor Cyan }
function Die($m) { Write-Host "error: $m" -ForegroundColor Red; exit 1 }
function Invoke-Git { & git @args; if ($LASTEXITCODE -ne 0) { Die "git $args failed" } }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Die "git not found. Install Git for Windows: winget install --id Git.Git -e"
}

Step "Checking access to $RepoUrl"
& git ls-remote -q $RepoUrl HEAD *> $null
if ($LASTEXITCODE -ne 0) { Die "cannot access $RepoUrl. Check your GitHub permission and SSH key (ssh -T git@github.com)." }

if (Test-Path (Join-Path $Dest ".git")) {
  Step "Updating existing clone at $Dest"
  Invoke-Git -C $Dest pull --ff-only
} elseif ((Test-Path $Dest) -and (Get-ChildItem -Force $Dest | Select-Object -First 1)) {
  Die "$Dest exists and is not empty. Pass another directory: -Dest <dir>"
} else {
  Step "Cloning into $Dest"
  New-Item -ItemType Directory -Force -Path (Split-Path $Dest) | Out-Null
  Invoke-Git clone $RepoUrl $Dest
}
$Dest = (Resolve-Path $Dest).Path

Step "Checking git identity (needed for auto-commits)"
$email = & git -C $Dest config user.email
if (-not $email) {
  $name = if ($env:GIT_USER_NAME) { $env:GIT_USER_NAME } else { Read-Host "git user.name" }
  $email = if ($env:GIT_USER_EMAIL) { $env:GIT_USER_EMAIL } else { Read-Host "git user.email" }
  if (-not $name -or -not $email) { Die "git user.name/user.email are required" }
  Invoke-Git -C $Dest config user.name $name
  Invoke-Git -C $Dest config user.email $email
  Write-Host "set for this repo: $name <$email>"
} else {
  Write-Host "using $(& git -C $Dest config user.name) <$email>"
}

Step "Installing CLAUDE.md into ~\.claude\CLAUDE.md"
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Dest "scripts\windows\install-claude-md.ps1")
if ($LASTEXITCODE -ne 0) { Die "CLAUDE.md install failed" }

Step "Installing watchdog (Scheduled Task)"
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Dest "scripts\windows\install.ps1") -Interval $Interval
if ($LASTEXITCODE -ne 0) { Die "watchdog install failed" }

Step "Done"
Write-Host "repo:      $Dest"
Write-Host "claude:    $HOME\.claude\CLAUDE.md"
Write-Host "watchdog:  Get-Content `"$env:LOCALAPPDATA\contexts-watchdog\watchdog.log`" -Wait"
