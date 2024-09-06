extends Node
class_name MoveManager

@export var state: MoveState
@export var player_body: CharacterBody2D

func _physics_process(delta: float) -> void:
	handle_inputs()
	handle_physics()
	
	var newState : MoveState = state.checkNextState()
	
	if newState != null:
		state.queue_free()
		state = newState
		add_child(state)
	
	var forces : Vector2 = state.applyMovement()
	
	apply_force(forces.x, forces.y, delta)

## Inputs --------------------------------------------------------------------
const JUMP_BUFFER := 0.2
const DROP_BUFFER := 0.2
const DASH_BUFFER := 0.2

var direction := 0
@onready var timeSinceJump := -JUMP_BUFFER
@onready var timeSinceDrop := -DROP_BUFFER
@onready var timeSinceDash := -DASH_BUFFER

func handle_inputs():
	direction = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("move_up"):
		timeSinceJump = Time.get_ticks_msec()
	
	if Input.is_action_just_pressed("move_down"):
		timeSinceDrop = Time.get_ticks_msec()
	
	if Input.is_action_just_pressed("move_dash"):
		timeSinceDash = Time.get_ticks_msec()

## Physics -------------------------------------------------------------------
const COYOTE_TIME := 0.2

@onready var timeSinceGrounded := -COYOTE_TIME

func handle_physics():
	if player_body.is_on_floor():
		timeSinceGrounded = Time.get_ticks_msec()

## Helpers -------------------------------------------------------------------
func apply_force(x, y, delta):
	player_body.velocity.x += x * delta
	player_body.velocity.y += y * delta
	
	player_body.move_and_slide()
