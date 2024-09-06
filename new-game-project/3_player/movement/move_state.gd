extends Node
class_name MoveState

@export var manager : MoveManager

func applyMovement()-> Vector2:
	return Vector2.ZERO

func checkNextState():
	pass

func createStateNode(node_name, script):
	var newNode = Node.new()
	newNode.name = node_name
	newNode.set_script(script)
	newNode.manager = manager
	return newNode
