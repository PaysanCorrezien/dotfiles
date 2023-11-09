function Set-UserPath {
    param(
        [string]$NewPath
    )
    $userPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)
    if ($userPath -notlike "*$NewPath*") {
        $userPath += ";$NewPath"
        [Environment]::SetEnvironmentVariable("PATH", $userPath, [EnvironmentVariableTarget]::User)
    }
}
Set-UserPath "\\wsl$\Debian\home\dylan\.local\share\chezmoi\dot_config\windows\PowershellScripts"
