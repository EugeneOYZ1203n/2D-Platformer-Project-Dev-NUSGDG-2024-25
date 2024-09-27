extends StaticBody2D

@export var collision_shape: CollisionShape2D
signal on_aesthetic_disappear
signal on_aesthetic_appear
signal on_physics_disappear
signal on_physics_appear

func disappear(delay):
	on_aesthetic_disappear.emit()
	await get_tree().create_timer(delay).timeout
	collision_shape.set_deferred("disabled", true)
	on_physics_disappear.emit()
	
func appear(delay):
	on_aesthetic_appear.emit()
	await get_tree().create_timer(delay).timeout
	collision_shape.set_deferred("disabled", false)
	on_physics_appear.emit()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	disappear(0.25)
	await get_tree().create_timer(3).timeout
	appear(0.2)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
