extends MoveState

@export var AIR_GRAVITY := 3500
@export var FALL_AIR_GRAVITY := 4000
@export var MAX_FALL_SPEED := 1500

@export var TARGET_MOVE_SPEED := 500
@export var IDLE_FRICTION_LOSS_MULT := 2.0
@export var TURN_ACCELERATION_MULT := 1.5
@export var APEX_ACCELERATION_MULT := 1.5

@onready var FRICTION_LOSS := 0.2
@onready var MOVE_ACCELERATION := (
		TARGET_MOVE_SPEED / (1-FRICTION_LOSS) -
		TARGET_MOVE_SPEED
	)

@onready var APEX_THRESHOLD := MAX_FALL_SPEED * 0.2

@onready var PHYSICS_TPS = ProjectSettings.get_setting("physics/common/physics_ticks_per_second")

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
	if (abs(player_body.velocity.y) < APEX_THRESHOLD):
		accel *= APEX_ACCELERATION_MULT
	
	player_body.velocity.x += accel
	player_body.velocity.x *= 1-friction
	
	var gravity = AIR_GRAVITY
	if player_body.velocity.y > 0:
		gravity = FALL_AIR_GRAVITY
	
	player_body.velocity.y += (gravity / PHYSICS_TPS)
	player_body.velocity.y = min(MAX_FALL_SPEED, 
								player_body.velocity.y)
	
	if input_handler.isGrounded():
		transition_state.emit("ground", self)
	if (input_handler.justJumped() and 
			input_handler.isCoyoteTime()):
		transition_state.emit("jump", self)
