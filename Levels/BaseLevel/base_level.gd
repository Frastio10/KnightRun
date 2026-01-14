extends Node2D
class_name BaseLevel

signal level_completed

const PLAYER := preload("res://Entities/Player/player.tscn")

var player: Node2D
var is_player_spawned := false


func complete_level() -> void:
	level_completed.emit()


func spawn_player(pos: Vector2) -> void:
	if is_player_spawned:
		return

	player = PLAYER.instantiate()
	add_child(player)

	player.global_position = pos
	is_player_spawned = true
