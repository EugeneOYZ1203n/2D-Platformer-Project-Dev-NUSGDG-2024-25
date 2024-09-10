extends Node
class_name InputHandler

@export var player_body: CharacterBody2D

func _physics_process(delta: float) -> void:
	handle_inputs()
	handle_physics()

## Inputs --------------------------------------------------------------------
const DIRECTION_CHANGE_BUFFER := 0.1
const JUMP_BUFFER := 0.1
const DROP_BUFFER := 0.1
const DASH_BUFFER := 0.1

var direction := 0
var timeSinceDirectionChange := -DIRECTION_CHANGE_BUFFER*1000
@onready var timeSinceJump := -JUMP_BUFFER*1000
@onready var timeSinceDrop := -DROP_BUFFER*1000
@onready var timeSinceDash := -DASH_BUFFER*1000


func handle_inputs():
	var newDirection = Input.get_axis("move_left", "move_right")
	if direction != newDirection:
		timeSinceDirectionChange = Time.get_ticks_msec()
	direction = newDirection
	
	if Input.is_action_just_pressed("jump"):
		timeSinceJump = Time.get_ticks_msec()
	
	if Input.is_action_just_pressed("move_down"):
		timeSinceDrop = Time.get_ticks_msec()
	
	if Input.is_action_just_pressed("move_dash"):
		timeSinceDash = Time.get_ticks_msec()

## Physics -------------------------------------------------------------------
const COYOTE_TIME := 0.2

@onready var timeSinceGrounded := -COYOTE_TIME*1000
var playerJumped := false

func handle_physics():
	if player_body.is_on_floor():
		# This line of code kept triggering after a jump
		# allowing double jumps, this boolean stops that
		if playerJumped:
			playerJumped = false
		else:
			timeSinceGrounded = Time.get_ticks_msec()

## Helpers
func getDirection() -> int:
	return direction

func justChangedDirection() -> bool:
	return (timeSinceDirectionChange + 
			DIRECTION_CHANGE_BUFFER*1000 
			> Time.get_ticks_msec())

func justJumped() -> bool:
	return (timeSinceJump + 
			JUMP_BUFFER*1000 
			> Time.get_ticks_msec())

func resetJumpTimers() -> void:
	playerJumped = true
	timeSinceJump = -JUMP_BUFFER*1000
	timeSinceGrounded = -COYOTE_TIME*1000

func isGrounded() -> bool:
	return player_body.is_on_floor()

func isCoyoteTime() -> bool:
	return (timeSinceGrounded + 
			COYOTE_TIME * 1000 > 
			Time.get_ticks_msec())
