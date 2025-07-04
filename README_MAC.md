# 🎮 Xspatial Game - Mac Setup

## 🚀 One-Click Launch Options

### Option 1: Double-Click App (Easiest)
1. **Double-click** `Xspatial Game.app`
2. Game launches automatically in your browser
3. Play Level 1 → Level 2 → Level 3 seamlessly

### Option 2: Terminal Script
1. **Double-click** `start_game.sh`
2. Or run in Terminal: `./start_game.sh`

## 🎯 How It Works

**The launcher automatically:**
- ✅ Starts Python web server
- ✅ Opens browser_game.html in your browser
- ✅ Handles all Level 1 → Level 2 → Level 3 progression
- ✅ Loads kernelSmooth.json for Level 3

**Game Progression:**
1. **🆕 NEW USERS**: Always start at Level 1 in browser_game.html
2. **Level 1**: Score ≥40 to advance to Level 2
3. **Level 2**: Score ≥80 to advance to Level 3  
4. **Level 3**: Automatically opens testbrowser.html
5. **🎯 PERMANENT LEVEL 3**: Once you reach Level 3, you ONLY play Level 3 (never go back to Levels 1-2)
6. **🚫 ACCESS CONTROL**: testbrowser.html redirects unqualified users to browser_game.html

## 🔧 Requirements

- **Python 3** (usually pre-installed on Mac)
- **Web browser** (Safari, Chrome, Firefox, etc.)

## 🎮 Usage

1. **Start**: Double-click `Xspatial Game.app` (opens browser_game.html)
2. **New Users**: Will always start at Level 1
3. **Play**: Complete levels to progress automatically (Level 1 → 2 → 3)
4. **Level 3**: Automatically redirects to testbrowser.html when qualified
5. **Stop**: Close Terminal window when done

## 📋 Entry Points

- **🎯 Recommended**: Use launcher → browser_game.html (starts from Level 1)
- **⚠️ Direct Access**: testbrowser.html redirects new users to browser_game.html

## 📁 Files Structure

```
Your Game Folder/
├── Xspatial Game.app        # Double-click launcher
├── start_game.sh            # Terminal launcher  
├── browser_game.html        # Levels 1-2
├── testbrowser.html         # Level 3
├── kernelSmooth.json        # Required data
└── README_MAC.md           # This file
```

## 🐛 Troubleshooting

**If the app doesn't open:**
1. Right-click `Xspatial Game.app` → "Open"
2. Click "Open" when prompted about unidentified developer

**If Python is missing:**
1. Install from: https://python.org
2. Or use Terminal: `brew install python3`

**If browser doesn't open:**
- Manually open: http://localhost:8000/browser_game.html

## ✨ Features

- 🔄 **Seamless Progression**: Level 1 → 2 → 3 automatically
- 💾 **Game State Persistence**: Continue exactly where you left off even after closing browser
- 👥 **Multi-User Support**: Each player has completely separate, unique game data
- 🏆 **Level 3 Permanence**: Once you reach Level 3, you stay in Level 3 forever (no going back)
- 🎯 **Try Number Tracking**: Persistent across sessions (per user)
- 🎲 **Random Environments**: Level 3 uses random environment selection
- 🌐 **Chrome Optimized**: Launcher automatically opens Chrome for best performance
- 📱 **Cross-Session Memory**: Game remembers your progress, level, and trial position
- 🔊 **Sound Support**: Audio works after first click
- ⚡ **Auto-Resume**: Restart game exactly where you stopped
- 🚀 **Smart Redirect**: Level 3 players automatically redirected to testbrowser.html
- 🔐 **User Isolation**: Different usernames have completely separate game states
- ⚡ **Seamless Experience**: No loading messages or delays - enter name and play instantly