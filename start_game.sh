#!/bin/bash

# Xspatial Game Launcher for Mac
# This script starts the Python server and opens the game automatically

echo ""
echo "================================================"
echo "🎮 XSPATIAL GAME LAUNCHER (Mac)"
echo "================================================"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if required files exist
if [ ! -f "testbrowser.html" ]; then
    echo "❌ ERROR: testbrowser.html not found in the same folder"
    echo "Please make sure this launcher is in the same folder as your game files"
    read -p "Press Enter to exit..."
    exit 1
fi

if [ ! -f "kernelSmooth.json" ]; then
    echo "❌ ERROR: kernelSmooth.json not found in the same folder"
    echo "Please make sure kernelSmooth.json is in the same folder as this launcher"
    read -p "Press Enter to exit..."
    exit 1
fi

if [ ! -f "browser_game.html" ]; then
    echo "❌ ERROR: browser_game.html not found in the same folder"
    echo "Please make sure browser_game.html is in the same folder as this launcher"
    read -p "Press Enter to exit..."
    exit 1
fi

echo "✅ All required files found"
echo ""

# Check if Python is available
if command -v python3 &> /dev/null; then
    echo "✅ Using python3..."
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    echo "✅ Using python..."
    PYTHON_CMD="python"
else
    echo "❌ ERROR: Python is not installed or not in PATH"
    echo "Please install Python from https://python.org"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo "🚀 Starting web server..."
echo "📚 Loading game with KernelSmooth.json data..."
echo ""

# Clean up any existing servers first
echo "🧹 Cleaning up any existing game servers..."
for port in {8000..8010}; do
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        echo "   Stopping server on port $port"
        lsof -ti :$port | xargs kill -9 2>/dev/null || true
    fi
done

sleep 2
echo "✅ Cleanup complete"

# Find an available port starting from 8000
PORT=8000
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
    PORT=$((PORT + 1))
    if [ $PORT -gt 8010 ]; then
        echo "❌ No available ports found between 8000-8010"
        read -p "Press Enter to exit..."
        exit 1
    fi
done

echo "🔍 Using port: $PORT"
echo "🚀 Starting web server on port $PORT..."
echo "📡 Server will show all requests below:"
echo "   (You'll see GET requests when the game loads files)"
echo ""

# Start browser first - try Chrome, fallback to default
echo "🌐 Opening browser_game.html in Chrome for full Level 1→2→3 progression..."
if command -v google-chrome &> /dev/null; then
    google-chrome "http://localhost:$PORT/browser_game.html" &
elif [ -d "/Applications/Google Chrome.app" ]; then
    open -a "Google Chrome" "http://localhost:$PORT/browser_game.html"
elif command -v chromium-browser &> /dev/null; then
    chromium-browser "http://localhost:$PORT/browser_game.html" &
else
    echo "⚠️ Chrome not found - using default browser"
    open "http://localhost:$PORT/browser_game.html"
fi
sleep 2

# Start the server (this will keep running)
echo ""
echo "🎯 Game should now be loading in your browser!"
echo "📚 Using real KernelSmooth.json data for authentic gameplay"
echo "🔊 Sound should work after first click (browser autoplay policy)"
echo ""
echo "🎮 GAME PROGRESSION:"
echo "   Level 1 → Level 2 (Score ≥40)"
echo "   Level 2 → Level 3 (Score ≥80) → Auto-opens testbrowser.html"
echo ""
echo "📋 Server Log (showing all requests):"
echo "======================================"
echo ""

# This will keep the server running
$PYTHON_CMD -m http.server $PORT