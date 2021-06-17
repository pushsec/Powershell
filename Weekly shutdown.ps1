New-Item -path "C:\Program Files" -Name "Scripts" -ItemType "Directory"
Copy-Item -Path ".\shot.ps1" -Destination "C:\Program Files\Scripts\shot.ps1"
$file = "C:\Program Files\Scripts\shot.ps1"
if (-not(Test-Path -Path $file -PathType Leaf)) {
    try {
    New-Item -path "C:\Program Files\Scripts\" -Name "shot.txt" -ItemType "File"
    Add-Content -Path "C:\Program Files\Scripts\shot.txt" -Value "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c shutdown -s'"
    Move-Item -Path "C:\Program Files\Scripts\shot.txt" -Destination "C:\Program Files\Scripts\shot.ps1"
    }
     catch {
         throw $_.Exception.Message
    }
    }
else {
     Write-Host "Cannot create [$file] because a file with that name already exists."
 }
$file = '"C:\Program Files\Scripts\shot.ps1"'
$A = New-ScheduledTaskAction -Execute "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" -Argument "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File $file "
$T = New-ScheduledTaskTrigger -Weekly -AT "22:00" -DaysOfWee Friday
$P = New-ScheduledTaskPrincipal "NT AUTHORITY\SYSTEM"
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask Weekly_Shutdown -InputObject $D

