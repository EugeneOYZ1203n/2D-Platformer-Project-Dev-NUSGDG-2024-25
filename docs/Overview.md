# Overview of Documentation

## Chapters
1. [Input and Physics Handling](Input_And_Physics_Handling.md)
2. [Player Move States](Player_Move_States.md)

## File structure
- 0_assets
    - Art, music and other assets
- 1_globals
    - Autoload global scripts
- 2_levels
    - 0_tests
        - Testing Levels
- 3_player
    - Player Scripts and Scenes
- 4_obstacles
    - Platforms, Hazards and other level props
- 5_misc
    - Level props with unique purposes like checkpoints

## Managing Levels (To be reworked in the future)
The 5_misc/next_level_area changes levels once the player touches it by calling the LevelManager.go_to_level() function, passing nxt_level as the index parameter

When adding 5_misc/next_level_area, remember to change the nxt_level variable in the editor to the index for the next level and include the next levels file path in 0_globals/level_manager.gd 

