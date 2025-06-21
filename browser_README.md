# Xspatial Browser Game

This is a fully client-side browser version of the Xspatial game. All functionalities including database operations, pellet dispensing, and UI are integrated into the browser without requiring server installation or dependencies.

## Features

- **No Installation Required**: Open the HTML files directly in your browser
- **Local Data Storage**: Game data is stored in your browser's localStorage
- **Complete Game Experience**: All levels (1-3) fully functional
- **Admin Panel**: Access and export game data
- **Level 3 Export Tool**: Special export functionality for Level 3 data
- **Pellet Dispenser Support**: Works with physical pellet dispensers on Windows

## How to Use

1. Open `browser_index.html` in your browser to access the game launcher
2. Click "Play Game" to start playing
3. Use Admin Panel for data administration
4. Use Level 3 Export for specialized data exports

## Keyboard Shortcuts

- `Ctrl+Shift+A` or `Cmd+Shift+A` (Mac): Access Admin Panel
- `Ctrl+Q` or `Cmd+Q` (Mac): Access Level 3 Export
- `Ctrl+Shift+P` or `Cmd+Shift+P` (Mac): Configure Pellet Dispenser
- `F`: Toggle fullscreen mode

## Physical Pellet Dispenser Setup (Windows Only)

To use a physical pellet dispenser on Windows:

1. Run `start_pellet_server.bat` to start the pellet server
2. In the game, press `Ctrl+Shift+P` to open the pellet configuration
3. Enable the pellet dispenser
4. Enter the full path to your `pellet.exe` (e.g., `C:\Program Files\Pellet\pellet.exe`)
5. Click "Save"

On non-Windows platforms, pellet dispensing will be simulated.

## Technical Information

- **Database**: Uses SQL.js for in-browser SQLite database operations
- **Storage**: Game data is saved in localStorage as a base64-encoded SQLite database
- **Browser Compatibility**: Works in modern browsers (Chrome, Firefox, Edge)
- **Offline-Ready**: Works entirely offline once loaded

## Game Levels

- **Level 1**: 10 trials, click squares to earn points (colors visible)
- **Level 2**: 20 trials, click squares to reveal colors and earn points
- **Level 3**: 25 trials in a grid layout with different environmental conditions

## Troubleshooting

- **Data Loss**: If game data is missing, check if localStorage has been cleared in your browser
- **Pellet Dispenser**: If the physical dispenser doesn't work:
  - Verify the pellet server is running
  - Ensure the correct pellet.exe path is entered
  - Check that the dispenser is enabled in settings
- **Performance**: If the game runs slowly, try closing other browser tabs/applications

## About Data Storage

All game data is stored locally in your browser's localStorage. This data persists between sessions unless you clear your browser data. You can export data through the Admin Panel for backup.