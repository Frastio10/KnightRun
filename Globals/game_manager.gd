extends Node

enum State {
	INGAME,
	MAIN_MENU
}

var _states_scenes: Dictionary[State, String] = {
	State.MAIN_MENU:  "res://States/MainMenu/main_menu.tscn",
	State.INGAME:  "res://States/InGame/ingame.tscn"
}

var _current_scene_root: Node

var current_level := 1
var current_scene := State.MAIN_MENU

var player_scores := {}

func add_score(level: int, data: Dictionary) -> void:
	player_scores[str(level)] = data

func set_level(level: int) -> void:
	current_level = level

func set_state(state: State) -> void:
	current_scene = state
	
	if _current_scene_root != null:
		_current_scene_root.queue_free()
	
	var scene: PackedScene = load(_states_scenes[state])
	_current_scene_root = scene.instantiate()
	add_child(_current_scene_root)
