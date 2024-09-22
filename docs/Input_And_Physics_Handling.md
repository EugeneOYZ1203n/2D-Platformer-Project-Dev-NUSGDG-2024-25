# Input and Physics Handling
Class name: InputHandler
Script name: input_handler.gd

### Inputs 
(Changed via Project > Project Settings > Input Map)
- Left (move_left)
- Right (move_right)
- Up (move_up)
- Down (move_down)
- Jump (move_jump)
- Dash (move_dash)
- Grab (move_grab)

### Buffered Inputs
- Buffered Direction Change
- Buffered Down
- Buffered Jump
- Buffered Dash
- Buffered Grab

### Physics Handling
- Grounded

### Helper functions
- getDirection()
	- Returns horizontal movement direction (-1, left to 1, right)
- getOmniDirection()
	- Returns 2D movement direction as Vector2
	- X values range from -1, left to 1, right
	- Y values range from -1, up to 1, down
- justChangedDirection()
	- Returns boolean, whether player has just changed horizontal direction
	- Time window can be adjusted with DIRECTION_CHANGE_BUFFER which is the number of seconds that this returns true
- justDropped()
	- Returns boolean, whether down button was just pressed (For dropping down one-way-platforms)
	- Time window can be adjusted with DROP_BUFFER which is the number of seconds that this returns true
- justJumped()
	- Returns boolean, whether jump button was just pressed
	- Time window can be adjusted with JUMP_BUFFER which is the number of seconds that this returns true
- justDashed()
	- Returns boolean, whether dash button was just pressed
	- Time window can be adjusted with DASH_BUFFER which is the number of seconds that this returns true
- justGrabbed() 
	- Returns boolean, whether grab button was just pressed
	- Time window can be adjusted with GRAB_BUFFER which is the number of seconds that this returns true
- isGrounded() 
	- Returns boolean, whether the player is currently grounded
- isCoyoteTime()
	- Returns boolean, whether the player was recently grounded
	- Time window can be adjusted with COYOTE_TIME which is the number of seconds that this returns true
	- Used for jumps to give players a grace period
- resetJumpTimers()
	- No return value
	- Resets Coyote time, Grounded timer and jump buffers
	- Should be called after a player jumps to prevent additional jumps using buffered inputs