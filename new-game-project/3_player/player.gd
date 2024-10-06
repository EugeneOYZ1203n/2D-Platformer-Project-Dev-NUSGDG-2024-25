extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()

func die() -> void:
	LevelManager.reset_level()
