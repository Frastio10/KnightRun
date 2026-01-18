extends Node
class_name BaseLevel

signal level_completed(data: Dictionary)
signal restart_level

const PLAYER := preload("res://Entities/Player/player.tscn")

var player: Player
var is_player_spawned := false
var score := 0

func _ready() -> void:
	add_to_group("level")
	
func _on_player_died() -> void:
	emit_signal("restart_level")

func add_score(points: int) -> void:
	score += points

func complete_level() -> void:
	var data = {
		"point": score
	}
	level_completed.emit(data)

func spawn_player(pos: Vector2) -> void:
	if is_player_spawned:
		return

	player = PLAYER.instantiate()
	add_child(player)
	player.died.connect(_on_player_died)

	player.global_position = pos
	is_player_spawned = true
