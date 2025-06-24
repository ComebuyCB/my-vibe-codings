@echo off
echo Updating project directory...
echo.

REM Get the current directory in Windows format
set "CURRENT_DIR=%~dp0"

REM Convert Windows path to WSL path
for /f "tokens=*" %%i in ('wsl wslpath "%CURRENT_DIR%"') do set "WSL_PATH=%%i"

REM Make the shell script executable and run it
wsl chmod +x "%WSL_PATH%update_directory.sh"
wsl bash "%WSL_PATH%update_directory.sh"

echo.
echo Press any key to close...
pause >nul