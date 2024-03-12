param (
  [string]$IP = $(wsl hostname -I).Trim(),
  [string]$GUICommand = "xfce4-session"
)

# Output the IP and GUI command for verification
Write-Host "Using IP: $IP"
Write-Host "Launching GUI command: $GUICommand"

# Start VcXsrv in fullscreen mode with specified settings
Start-Process -FilePath "C:\Program Files\VcXsrv\vcxsrv.exe" -ArgumentList "-fullscreen -clipboard -swcursor -unixkill -keyhook -silent-dup-error -nowinkill -wgl -ac" -NoNewWindow -PassThru

# Start PulseAudio
Start-Process -FilePath "pulseaudio" -ArgumentList "--use-pid-file=false", "-D" -NoNewWindow -PassThru

# Wait a moment for VcXsrv to fully start
Start-Sleep -Seconds 2

# Execute the bash script in WSL, passing the IP and GUI command as arguments
wsl ~/launch_gui.sh $IP $GUICommand

