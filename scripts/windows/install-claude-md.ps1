# Renders <repo>/CLAUDE.md into ~/.claude/CLAUDE.md as a managed block,
# replacing {{CONTEXTS_DIR}} with this clone's location.
#
# Usage: install-claude-md.ps1 [-IfManaged]
#   -IfManaged  only refresh an existing managed block (used by the watchdog)
param(
  [switch]$IfManaged,
  [string]$RepoDir = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)
$ErrorActionPreference = "Stop"

$Template = Join-Path $RepoDir "CLAUDE.md"
$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME ".claude" }
$Target = Join-Path $ClaudeDir "CLAUDE.md"
$BeginPrefix = "<!-- BEGIN contexts"
$EndLine = "<!-- END contexts -->"
$Utf8 = New-Object System.Text.UTF8Encoding($false)

if (-not (Test-Path $Template)) { throw "template not found: $Template" }

$dir = $RepoDir
if ($dir.StartsWith($HOME, [StringComparison]::OrdinalIgnoreCase)) { $dir = "~" + $dir.Substring($HOME.Length) }
$dir = $dir -replace "\\", "/"

$content = ([IO.File]::ReadAllText($Template, $Utf8)).TrimEnd("`r", "`n").Replace("{{CONTEXTS_DIR}}", $dir)
$block = "$BeginPrefix (managed; edit $dir/CLAUDE.md, not this block) -->`n$content`n$EndLine"

$old = if (Test-Path $Target) { [IO.File]::ReadAllText($Target, $Utf8) } else { "" }
$lines = if ($old) { $old -split "`r?`n" } else { @() }
$begin = [Array]::FindIndex([string[]]$lines, [Predicate[string]]{ param($l) $l.StartsWith($BeginPrefix) })

if ($begin -ge 0) {
  $end = [Array]::IndexOf([string[]]$lines, $EndLine, $begin)
  if ($end -lt 0) { throw "found '$BeginPrefix' without '$EndLine' in $Target" }
  $before = if ($begin -gt 0) { ($lines[0..($begin - 1)] -join "`n") + "`n" } else { "" }
  $after = if ($end + 1 -lt $lines.Count) { "`n" + ($lines[($end + 1)..($lines.Count - 1)] -join "`n") } else { "" }
  $new = $before + $block + $after
} elseif ($IfManaged) {
  exit 0
} else {
  New-Item -ItemType Directory -Force -Path $ClaudeDir | Out-Null
  if ($old.Trim()) {
    $backup = "$Target.bak." + (Get-Date -Format "yyyyMMddHHmmss")
    Copy-Item $Target $backup
    Write-Host "backed up existing $Target -> $backup"
    $new = $old.TrimEnd("`r", "`n") + "`n`n" + $block + "`n"
  } else {
    $new = $block + "`n"
  }
}

if ($new -ne $old) {
  [IO.File]::WriteAllText($Target, $new, $Utf8)
  Write-Host "updated $Target"
}
