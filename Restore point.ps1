$A = New-ScheduledTaskAction -Execute "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" -Argument '-ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description \"My Restore Point Startup\" -RestorePointType \"MODIFY_SETTINGS\"" '
$T = New-ScheduledTaskTrigger -Weekly -AT "12:00" -DaysOfWee Wednesday
$P = New-ScheduledTaskPrincipal "NT AUTHORITY\SYSTEM"  -RunLevel Highest
$S = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask Weekly_Restore_Point -InputObject $D

