@echo off
echo Starting Xspatial Browser Game...
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"

REM Determine which browser to use
where chrome.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using Chrome to open the game...
    start chrome.exe "%SCRIPT_DIR%browser_index.html"
    goto end
)

where msedge.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using Microsoft Edge to open the game...
    start msedge.exe "%SCRIPT_DIR%browser_index.html"
    goto end
)

where firefox.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using Firefox to open the game...
    start firefox.exe "%SCRIPT_DIR%browser_index.html"
    goto end
)

REM If no known browser is found, use the default browser
echo Using default browser to open the game...
start "" "%SCRIPT_DIR%browser_index.html"

:end
echo.
echo Game launched! Close this window when finished.
pause