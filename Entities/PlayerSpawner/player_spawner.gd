extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	call_deferred("_add_player_to_tree")

func _add_player_to_tree() -> void:
	get_parent().spawn_player(global_position)
