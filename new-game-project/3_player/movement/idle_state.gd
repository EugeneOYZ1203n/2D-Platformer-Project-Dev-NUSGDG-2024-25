extends MoveState

const GROUND_STATE_SCRIPT = preload("res://3_player/movement/ground_state.gd")

const IDLE_GRAVITY := 50

func applyMovement() -> Vector2:
	return Vector2(0, IDLE_GRAVITY)

func checkNextState():
	if manager.direction != 0:
		return createStateNode("Ground", GROUND_STATE_SCRIPT)
