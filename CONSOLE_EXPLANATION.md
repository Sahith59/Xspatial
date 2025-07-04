# Console Messages Explanation - Testbrowser.html

## Overview
The console displays detailed information about the game setup, grid layout, and every player interaction. This guide explains what each message means.

## Game Initialization Messages

### Grid Sizing and Layout
```
Grid sizing - Available space: 1472x820px (reserved 70px for sun), Square size: 67.2px
```
- **Available space**: Screen dimensions minus UI elements (sun, info panels)
- **Reserved space**: Space set aside for sun animation and UI elements
- **Square size**: Calculated optimal size for each grid square

```
Grid Layout - Canvas: 1512x950, Grid: 1008.2x820.0
   Square: 67.2px, Horizontal spacing: 67.2px, Vertical spacing: 40.3px
   Position: (251.9, 90.0) - 20.0px spacing from sun
```
- **Canvas**: Total drawing area dimensions
- **Grid**: Actual 8x8 grid dimensions on screen
- **Spacing**: Distance between squares (horizontal vs vertical)
- **Position**: Where the grid starts (x, y coordinates)
- **Sun spacing**: Safe distance maintained from sun animation

```
Grid safely positioned with 20.0px spacing from sun, 40.0px from bottom
```
- Confirms no overlap with UI elements

### Environment and Data Loading
```
Creating Level 3 grid using KernelSmooth data
Using environment 27 (try number 2)
```
- **Environment 27**: Specific spatial pattern being used (0-39 available)
- **Try number 2**: Current attempt/session number

```
Grid[0][0] = 35 (from KernelSmooth value 0.8009, scale 38, original calc: 40.04 → 40 → 35)
```
- **Grid[0][0]**: Position in 8x8 grid (row 0, column 0)
- **35**: Final point value for this square
- **0.8009**: Original value from research data (0-1 range)
- **Scale 38**: Trial-specific scaling factor (30-40 range)
- **Calculation steps**: 0.8009 × 50 = 40.04 → +noise = 40 → ×scale+offset = 35

```
Initialized 64 squares using KernelSmooth environment 27
```
- All 64 squares in 8x8 grid have been created with real research data

### Game State
```
Restored game state: 39 revealed squares
```
- Player previously revealed 39 squares, continuing from saved progress

## Click/Trial Data (Per Click)

### Complete Experiment Data Log
```
=== TRIAL 1 DATA ===
Tile Position: (3, 2)
Points Earned: 34

ORIGINAL EXPERIMENT VALUES:
   x: 3 (tile X coordinate 0-7)
   y: 2 (tile Y coordinate 0-7)  
   z: 34 (raw reward value)
   zscaled: 30.42 (scale-adjusted value)
   trial: 1 (trial number within try)
   block: 2 (block/try number)
   monkeyid: TestPlayer (player identifier)
   scale: 38 (trial scale factor 30-40)
   envOrder: 27 (environment index 0-39)
   pellet_count: 4 (pellets dispensed 1-5)
   environment: S (R=Rough, S=Smooth)

CALCULATION DETAILS:
   Raw Kernel Value: 0.8009 (from KernelSmooth data)
   Grid Index: 19 (linear position in 8x8 grid)
   Environment Type: S (Odd=Smooth)
===============================
```

**Explanation of each value:**

| Value | Description | Range | Example |
|-------|-------------|-------|---------|
| **x** | Column position in grid | 0-7 | 3 |
| **y** | Row position in grid | 0-7 | 2 |
| **z** | Points earned (final reward) | 5-50 | 34 |
| **zscaled** | Raw kernel value × scale factor | Variable | 30.42 |
| **trial** | Trial number within current try | 1-25 | 1 |
| **block** | Try/session number | 1+ | 2 |
| **monkeyid** | Player name | Text | "TestPlayer" |
| **scale** | Random scaling factor per try | 30-40 | 38 |
| **envOrder** | Environment pattern used | 0-39 | 27 |
| **pellet_count** | Physical pellets dispensed | 1-5 | 4 |
| **environment** | Environment type | R/S | S |

**Additional Details:**
- **Raw Kernel Value**: Original spatial value from research data (0-1)
- **Grid Index**: Linear position (row × 8 + column) = 2 × 8 + 3 = 19
- **Environment Type**: Even numbers = Rough (R), Odd numbers = Smooth (S)

## Understanding the Data

### Reward Calculation Process
1. **Start**: Get raw spatial value from KernelSmooth data (0-1 range)
2. **Scale**: Multiply by 50 to get 0-50 range
3. **Add noise**: Apply Gaussian noise for variability
4. **Rescale**: Apply trial-specific scale factor (30-40) plus base offset (+5)
5. **Final**: Clamp to valid range, this becomes the point reward

### Environment Types
- **R (Rough)**: Even environment numbers (0, 2, 4, 6, ...)
- **S (Smooth)**: Odd environment numbers (1, 3, 5, 7, ...)
- **Purpose**: Different spatial correlation patterns for research

### Trial Structure
- **Try**: Complete 25-trial session with one environment
- **Block**: Equivalent to try number for data analysis
- **Trial**: Individual click within a try (1-25)

This logging system captures all data needed for spatial cognition research analysis, matching the original experiment format exactly.