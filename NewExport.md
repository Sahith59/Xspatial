Overview

  This document provides a detailed description of all parameters used in the level3_custom_export.html data export file. The export file is specifically
  designed for Level 3 of the spatial search game, providing data in a format suitable for spatial search analysis.

  Parameters

  1. "#" (Index)

  - Description: A sequential row identifier/counter
  - Calculation: Simple integer increment (1, 2, 3, ...) for each data row
  - Code Location: browser_level3_custom_export.html, lines 481-486 (in CSV creation)
  - Usage: Used to uniquely identify each row in the dataset

  2. "x" (X Coordinate)


  - Description: The X coordinate of the tile in the grid (0-7)
  - Calculation:
    - If available from database: trial.tileX is used (browser_level3_custom_export.html, line 694-695)
    - If from custom tile data: clickData.tileX is used (browser_level3_custom_export.html, line 694)
    - As fallback: Calculated as gridPosition % 8 (browser_level3_custom_export.html, lines 716-718)
  - Code Location: browser_level3_custom_export.html, lines 692-726
  - Usage: Horizontal position of the clicked tile in the spatial grid

  3. "y" (Y Coordinate)

  - Description: The Y coordinate of the tile in the grid (0-7)
  - Calculation:
    - If available from database: trial.tileY is used (browser_level3_custom_export.html, line 694-695)
    - If from custom tile data: clickData.tileY is used (browser_level3_custom_export.html, line 694)
    - As fallback: Calculated as Math.floor(gridPosition / 8) (browser_level3_custom_export.html, lines 716-718)
  - Code Location: browser_level3_custom_export.html, lines 692-726
  - Usage: Vertical position of the clicked tile in the spatial grid

  4. "z" (Raw Reward Value)

  - Description: The raw reward value associated with a tile (range 0-50)
  - Calculation:
    - If stored z-value exists: Uses stored value (browser_level3_custom_export.html, lines 749-750)
    - Otherwise: Math.round(normalizedScore * 50) (normalizedScore is (trial.score || 0) / 5)
    - In direct export: Math.round(trial.rewardValue * 50) (browser_level3_custom_export.html, line 444)
  - Code Location: browser_level3_custom_export.html, lines 733-776 (calculation)
  - Usage: Represents the raw reward value of a tile before scaling

  5. "zscaled" (Normalized Reward Value)

  - Description: The reward value after scaling (normalization)
  - Calculation:
    - If stored zscaled value exists: Uses stored value (browser_level3_custom_export.html, lines 749-750)
    - Otherwise: Math.round(rawZ * scale / 40) (browser_level3_custom_export.html, line 763)
  - Code Location: browser_level3_custom_export.html, lines 749-763
  - Usage: Normalized reward value adjusted by the scaling factor

  6. "trial" (Trial Number)

  - Description: Sequential number identifying each trial within a block/session
  - Calculation: Directly from trial.trial_number in the database
  - Code Location: browser_level3_custom_export.html, line 790
  - Usage: Tracks the order of trials within a session/block

  7. "block" (Block/Session Number)

  - Description: The block or session number, equivalent to "try_number" in the database
  - Calculation: Directly from trial.try_number in the database
  - Code Location: browser_level3_custom_export.html, line 792
  - Usage: Identifies different experimental sessions or blocks

  8. "monkeyid" (Monkey Identifier)

  - Description: The ID/name of the monkey participant
  - Calculation: Uses the monkey's name from trial.monkey_name
  - Code Location: browser_level3_custom_export.html, line 793
  - Usage: Identifies the participant in the experiment

  9. "scale" (Scaling Factor) 
    - Description: A factor used to normalize reward values
    - Calculation:
    - In each round, the underlying rewards were scaled to a randomly drawn maximum value in the range of 70% to 90% 
     of the darkest reward value. Re-clicked tiles could show small variations in the observed color (i.e., underlying reward) due to normally distributed
     noise, ∼ N(0, 1).
         of the darkest reward value. Re-clicked tiles could show small variations in the observed color (i.e., underlying reward) due to normally distributed noise, ∼ N(0, 1).
    original experiment, where rewards were scaled to a random maximum value. In the browser implementation, this is deterministically calculated based on the block/try number to ensure consistency, with values typically ranging from 33-44 (depending on the implementation pattern). where rewards were scaled to a random maximum value. In the browser implementation, this is deterministically calculated based on the block/try number to ensure consistency, with values typically ranging from 33-44 (depending on the implementation pattern).

    Code Location: browser_level3_custom_export.html, lines 733-734

    10. "envOrder" (Environment Order Number)
     
      - Description: A value related to the environment ordering
      - Calculation:
      - Description: An identifier for the environment used in a particular block/session
      - "On each round, a new environment is sampled without replacement from a set of 40 environments generated for each class from a radial basis function kernel, with λsmooth = 4 and λrough = 1. The sampled environments defined a bivariate reward function on the grid, with each reward including additional normally distributed noise, such that there were slight variations in reward when repeatedly clicking a tile."
        each class from a radial basis function kernel, with λsmooth = 4 and λrough = 1. The sampled environments defined a bivariate reward function on the grid, with each reward including additional normally distributed noise, such that there were slight variations in reward when repeatedly clicking a tile."
      - Code Location: browser_level3_custom_export.html, lines 736-742
      - Usage: Tracks environmental conditions across different blocks/sessions
      - Usage: The envOrder parameter represents the index of the environment being used from the 40 predefined environments. In the original experiment, this would reference a specific environment from the kernelSmooth.json file. In the browser implementation, this is simulated by generating values based on the trial/block number, as the actual kernelSmooth.json lookup is not implemented. The value helps track which specific environment configuration was used for each session.this would reference a specific environment from the kernelSmooth.json file. In the browser implementation, this is simulated by generating values based on the trial/block number.

  11. "pellet_count" (Additional Parameter in Some Exports)

  - Description: Number of pellet rewards given for a tile
  - Calculation:
    - If stored value exists: Uses stored value
    - Otherwise: Math.ceil(z / 10) or Math.round(trial.rewardValue * 5) or 1
    - In some contexts: trial.score || trial.pellet_count || Math.ceil(rawZ / 10) (browser_level3_custom_export.html, line 766)
  - Code Location: browser_level3_custom_export.html, lines 454-456 (in direct export)
  - Usage: Represents the number of pellet rewards given for a particular trial

  Data Storage and Consistency Mechanisms

  Z-Value Storage

  - Purpose: Ensures consistent z-values across exports
  - Implementation: Uses localStorage to store z and zscaled values by key
  - Key Format: ${block}_${trial} (e.g., "1_3" for block 1, trial 3)
  - Code Location: browser_level3_custom_export.html, lines 964-981 (getStoredZValue)

  Custom Tile Data

  - Purpose: Stores custom coordinate data for tiles
  - Implementation: Uses localStorage item 'level3TileData'
  - Format: JSON object with try_number keys and arrays of click data
  - Code Location: browser_level3_custom_export.html, lines 382-393 (loading data)

  Export Formats

  CSV Export

  - Header: "#","x","y","z","zscaled","trial","block","monkeyid","scale","envOrder","pellet_count"
  - Code Location: browser_level3_custom_export.html, lines 1280-1287 (CSV formatting)

  JSON Export

  - Fields: index, x, y, z, zscaled, trial, block, monkeyid, scale, envOrder, pellet_count
  - Code Location: browser_level3_custom_export.html, lines 1331-1349 (JSON formatting)

  Data Generation and Fallback Mechanisms

  When data is missing or insufficient, the export tool includes mechanisms to generate consistent data:

  generateDataForTryNumber

  - Purpose: Creates synthetic but consistent data for a specific try/block
  - Implementation: Uses deterministic algorithms based on monkey name, try number, and trial
  - Code Location: browser_level3_custom_export.html, lines 984-1046

  generateFallbackData

  - Purpose: Creates complete fallback data when database access fails
  - Implementation: Generates synthetic data for multiple blocks
  - Code Location: browser_level3_custom_export.html, lines 859-913