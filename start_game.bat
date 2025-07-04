@echo off
title Xspatial Game Launcher
color 0A

echo.
echo  ================================================
echo   🎮 XSPATIAL GAME LAUNCHER
echo  ================================================
echo.

cd /d "%~dp0"

REM Check if required files exist
if not exist "testbrowser.html" (
    echo ❌ ERROR: testbrowser.html not found in the same folder
    echo Please make sure this launcher is in the same folder as your game files
    pause
    exit /b 1
)

if not exist "kernelSmooth.json" (
    echo ❌ ERROR: kernelSmooth.json not found in the same folder
    echo Please make sure kernelSmooth.json is in the same folder as this launcher
    pause
    exit /b 1
)

echo ✅ All required files found
echo.

REM Check if Python is available
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Using python...
    set PYTHON_CMD=python
    goto :start_server
) else (
    REM Try python3
    python3 --version >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✅ Using python3...
        set PYTHON_CMD=python3
        goto :start_server
    ) else (
        echo ❌ ERROR: Python is not installed or not in PATH
        echo Please install Python from https://python.org
        echo.
        pause
        exit /b 1
    )
)

:start_server
echo 🚀 Starting web server on port 8000...
echo 📚 Loading game with KernelSmooth.json data...
echo.

REM Clean up any existing servers first
echo 🧹 Cleaning up any existing game servers...
for /L %%p in (8000,1,8010) do (
    for /f "tokens=5" %%a in ('netstat -ano ^| find ":%%p " ^| find "LISTENING"') do (
        echo    Stopping server on port %%p (PID: %%a)
        taskkill /PID %%a /F >nul 2>&1
    )
)
timeout /t 2 /nobreak >nul
echo ✅ Cleanup complete

REM Find an available port starting from 8000
set PORT=8000
:find_port
netstat -an | find ":%PORT%" | find "LISTENING" >nul
if %errorlevel% equ 0 (
    set /a PORT+=1
    if %PORT% leq 8010 goto find_port
    echo ❌ No available ports found between 8000-8010
    pause
    exit /b 1
)

echo 🔍 Using port: %PORT%
echo 🚀 Starting web server on port %PORT%...
echo 📡 Server will show all requests below:
echo    (You'll see GET requests when the game loads files)
echo.

REM Start browser first - now opens browser_game.html for full progression
start "" http://localhost:%PORT%/browser_game.html
timeout /t 2 /nobreak >nul

REM Start the server (this will keep running)
echo.
echo 🎯 Game should now be loading in your browser!
echo 📚 Using real KernelSmooth.json data for authentic gameplay
echo 🔊 Sound should work after first click (browser autoplay policy)
echo.
echo 📋 Server Log (showing all requests):
echo ======================================
echo.

%PYTHON_CMD% -m http.server %PORT%