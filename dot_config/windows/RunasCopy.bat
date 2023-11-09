@echo off
set /p "username=Enter username: "
runas /user:%username% "powershell.exe -File C:\userconfig\neovimWinsudo.ps1"

