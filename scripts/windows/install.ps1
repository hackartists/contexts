# Registers the contexts watchdog as a Scheduled Task: runs hidden at logon, restarts on failure.
# Usage: powershell -ExecutionPolicy Bypass -File install.ps1 [-Interval 30]
param([int]$Interval = 30)

$TaskName = "ContextsWatchdog"
$Script   = Join-Path $PSScriptRoot "watchdog.ps1"

$action = New-ScheduledTaskAction -Execute "powershell.exe" `
  -Argument "-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$Script`" -Interval $Interval"
$trigger  = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
  -StartWhenAvailable -RestartCount 999 -RestartInterval (New-TimeSpan -Minutes 1) `
  -ExecutionTimeLimit ([TimeSpan]::Zero) -MultipleInstances IgnoreNew

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings `
  -Description "Auto pull/commit/push for the contexts repo" -Force | Out-Null
Start-ScheduledTask -TaskName $TaskName

Write-Host "installed: $TaskName"
Write-Host "log:       $env:LOCALAPPDATA\contexts-watchdog\watchdog.log"
