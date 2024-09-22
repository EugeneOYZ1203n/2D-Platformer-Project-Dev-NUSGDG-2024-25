# Player Move States
Class name: MoveState
Script name: move_state.gd

### Why a Movement state machine?
The player movement is implemented in the form of a finite state machine. This brings the following benefits:
1. Prevents nested if-else statements
2. Delegates state-specific behaviour to the state classes
3. Separates state-specific variables to the state classes
4. States can handle transitions between each other
5. Single Responsibility + Open/Closed Principle of SOLID Principles

Extra Reading: https://refactoring.guru/design-patterns/state#:~:text=Finite%2DState%20Machine.,one%20state%20to%20another%20instantaneously.

### Move State structure
- player_body (CharacterBody2D)
    - Set by the State Machine
    - Allows Move State to access the player_body and read/change its velocity
- input_handler (InputHandler)
    - Set by the State Machine
    - Allows Move State to access inputs and physics state
    - Refer to [Input and Physics Handling](Input_And_Physics_Handling.md)
- transition_state (Signal)
    - Signal that is emitted when state needs to be transitioned
    - Params for emitting Signal
        - Name of next state, in lower case
        - Current state node, `self` in most cases
    - E.g `transition_state.emit("air", self)`
- enter()
    - Called by State Machine once when entering state
- exit()
    - Called by State Machine once when exiting state
- update()
    - Called by State Machine once every process update frame
- physics_update()
    - Called by State Machine once every physics process update frame
    - Movement calculations and Physics should be done here instead of update()

### Creating a new Move State
1. Create a new Node under `MovementSM` in the Player Scene
2. Rename the node to the name of the new state
3. Create a new script for this node
4. Copy and paste this template code
``` python
extends MoveState

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	pass
```