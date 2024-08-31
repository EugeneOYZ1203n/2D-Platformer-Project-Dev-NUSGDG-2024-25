extends Node

const levels = {
	1 : "res://2_levels/0_tests/testing_level.tscn",
	2 : "res://2_levels/0_tests/testing_level_2.tscn",
}

var root : Node
var curr : Node2D

func _ready() -> void:
	root = get_tree().root
	curr = root.get_child(-1)

func go_to_level(index):
	root.remove_child(curr)
	curr = load(levels[index]).instantiate()
	root.add_child(curr)
