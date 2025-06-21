#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Starting Xspatial Browser Game..."
echo ""

# Try different browsers in order of preference
if command -v google-chrome &> /dev/null; then
    echo "Opening with Chrome..."
    google-chrome "$SCRIPT_DIR/browser_index.html"
elif command -v firefox &> /dev/null; then
    echo "Opening with Firefox..."
    firefox "$SCRIPT_DIR/browser_index.html"
elif command -v chromium-browser &> /dev/null; then
    echo "Opening with Chromium..."
    chromium-browser "$SCRIPT_DIR/browser_index.html"
else
    echo "No supported browser found. Please open the file manually:"
    echo "$SCRIPT_DIR/browser_index.html"
    echo ""
    echo "Or install one of these browsers: Chrome, Firefox, or Chromium"
fi

echo ""
echo "Game launched! You can close this Terminal window."