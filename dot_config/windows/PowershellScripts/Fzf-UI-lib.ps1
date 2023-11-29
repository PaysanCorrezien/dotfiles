function Draw-Header {
    # Move cursor to the top of the terminal and clear the header lines
    [Console]::SetCursorPosition(0, 0)
    1..5 | ForEach-Object { Write-Host "`e[2K" } # Assuming the header occupies 5 lines
    [Console]::SetCursorPosition(0, 0)

    # Draw the styled header
    Write-Host "`e[1;33mSelect Files (use TAB to mark multiple)`e[0m"
    Write-Host "`e[1;32mInstructions:`e[0m"
    Write-Host "`e[34m- TAB to toggle selection`e[0m"
    Write-Host "`e[34m- Enter to confirm`e[0m"
    Write-Host "`e[34m- ESC to cancel`e[0m"
}

# Main script loop
while ($true) {
    Draw-Header

    # Define additional info for fzf header (including footer-like information)
    $fzfHeader = @"
Keybindings:
[CTRL-N]: Cycle Next
[CTRL-P]: Cycle Previous
"@

    # Run fzf with custom header and header lines
    $selectedFiles = ls -Name | fzf --height 90% --header "$fzfHeader" 

    if ([string]::IsNullOrEmpty($selectedFiles)) {
        Write-Host "No selection made."
        break
    } else {
        Write-Host "You selected:"
        Write-Host $selectedFiles
    }

    Start-Sleep -Seconds 2
}

Clear-Host
