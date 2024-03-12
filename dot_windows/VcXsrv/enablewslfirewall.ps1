# Define paths to the executables
$vcxsrvPath = "C:\Program Files\VcXsrv\vcxsrv.exe"
$pulseAudioPath = "C:\ProgramData\chocolatey\bin\pulseaudio.exe"

# Check if the paths exist before creating rules
if (Test-Path -Path $vcxsrvPath)
{
  New-NetFirewallRule -DisplayName "VcXsrv" -Direction Inbound -Program $vcxsrvPath -Action Allow -Profile Domain,Private -Description "Allow inbound traffic to VcXsrv"
} else
{
  Write-Warning "VcXsrv path $vcxsrvPath does not exist. Please check the path."
}

if (Test-Path -Path $pulseAudioPath)
{
  New-NetFirewallRule -DisplayName "PulseAudio" -Direction Inbound -Program $pulseAudioPath -Action Allow -Profile Domain,Private -Description "Allow inbound traffic to PulseAudio"
} else
{
  Write-Warning "PulseAudio path $pulseAudioPath does not exist. Please check the path."
}

