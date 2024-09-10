extends MoveState

@export var TARGET_MOVE_SPEED := 500
@export var GROUND_GRAVITY := 50

@export var IDLE_FRICTION_LOSS_MULT := 2.0
@export var TURN_ACCELERATION_MULT := 1.5

@onready var FRICTION_LOSS := 0.2
@onready var MOVE_ACCELERATION := (
		TARGET_MOVE_SPEED / (1-FRICTION_LOSS) -
		TARGET_MOVE_SPEED
	)

func enter():
	pass

func exit():
	pass

func update():
	pass

func physics_update():
	var accel = MOVE_ACCELERATION
	var friction = FRICTION_LOSS
	var direction = input_handler.getDirection()
	accel *= direction
	if direction == 0:
		friction *= IDLE_FRICTION_LOSS_MULT
		friction = max(1.0, friction)
	if (input_handler.justChangedDirection() and 
			abs(player_body.velocity.x) > 0.7 * TARGET_MOVE_SPEED):
		accel *= TURN_ACCELERATION_MULT
	
	player_body.velocity.x += accel
	player_body.velocity.x *= 1-friction
	
	player_body.velocity.y = GROUND_GRAVITY
	if not input_handler.isGrounded():
		transition_state.emit("air", self)
	if (input_handler.justJumped()):
		transition_state.emit("jump", self)
