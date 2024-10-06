extends Node

const levels = {
	1 : "res://2_levels/0_tests/testing_level.tscn",
	2 : "res://2_levels/0_tests/testing_level_2.tscn",
}

var root : Node
var curr_index : int = 1
var curr : Node2D

func _ready() -> void:
	root = get_tree().root
	curr = root.get_child(-1)

func reset_level():
	load_level(curr_index)

func go_to_level(index):
	load_level(index)

func load_level(index):
	root.remove_child(curr)
	curr.queue_free()
	curr = load(levels[index]).instantiate()
	root.add_child(curr)
	curr_index = index
