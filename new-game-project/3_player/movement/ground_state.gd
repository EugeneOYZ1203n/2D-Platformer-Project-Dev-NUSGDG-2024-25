extends MoveState



func applyMovement() -> Vector2:
	return Vector2.ZERO

func checkNextState():
	if manager.direction != 0:
		return 
