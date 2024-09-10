extends MoveState

@export var JUMP_HEIGHT := 280
@export var AIR_GRAVITY := 3500

@onready var JUMP_IMPULSE := sqrt(2 * AIR_GRAVITY * JUMP_HEIGHT)

func enter():
	input_handler.resetJumpTimers()
	player_body.velocity.y -= JUMP_IMPULSE
	player_body.velocity.y = min(-JUMP_IMPULSE, player_body.velocity.y)

func exit():
	pass

func update():
	transition_state.emit("air", self)

func physics_update():
	pass
