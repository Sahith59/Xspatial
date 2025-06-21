#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Starting Xspatial Browser Game..."
echo ""

# Try to open with Chrome first, then Safari, then default browser
if [ -d "/Applications/Google Chrome.app" ]; then
    echo "Opening with Chrome..."
    open -a "Google Chrome" "$SCRIPT_DIR/browser_index.html"
elif [ -d "/Applications/Safari.app" ]; then
    echo "Opening with Safari..."
    open -a "Safari" "$SCRIPT_DIR/browser_index.html"
else
    echo "Opening with default browser..."
    open "$SCRIPT_DIR/browser_index.html"
fi

echo ""
echo "Game launched! You can close this Terminal window."