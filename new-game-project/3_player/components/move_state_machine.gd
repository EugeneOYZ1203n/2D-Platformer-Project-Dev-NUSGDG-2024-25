extends Node
class_name MoveStateMachine

@export var initial_state : MoveState

var current_state : MoveState
var states : Dictionary = {}

@export var player_body: CharacterBody2D
@export var input_handler: InputHandler

func _ready() -> void:
	for child in get_children():
		if child is MoveState:
			states[child.name.to_lower()] = child
			child.transition_state.connect(on_state_transition)
			child.player_body = player_body
			child.input_handler = input_handler
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update()

func _process(delta: float) -> void:
	if current_state:
		current_state.update()

func on_state_transition(
		new_state_name: String, 
		old_state: MoveState):
	
	if old_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
