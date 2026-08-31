@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\install.ps1" -Scope User -Force
set "studio_exit=%ERRORLEVEL%"
if not "%studio_exit%"=="0" echo Repair failed. Read the error above.
pause
exit /b %studio_exit%
