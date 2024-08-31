extends Area2D

@export var nxt_level : int = 1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		LevelManager.go_to_level(nxt_level)
