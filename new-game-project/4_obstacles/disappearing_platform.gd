extends StaticBody2D

@export var collision_shape: CollisionShape2D
@export var appear_delay: float
@export var disappear_delay: float
@export var disappear_duration: float

signal on_aesthetic_disappear
signal on_aesthetic_appear

func disappear(delay):
	on_aesthetic_disappear.emit()
	await get_tree().create_timer(delay).timeout
	collision_shape.set_deferred("disabled", true)
	
func appear(delay):
	on_aesthetic_appear.emit()
	await get_tree().create_timer(delay).timeout
	collision_shape.set_deferred("disabled", false)

func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	disappear(disappear_delay)
	await get_tree().create_timer(disappear_duration).timeout
	appear(appear_delay)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
