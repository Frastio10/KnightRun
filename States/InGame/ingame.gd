extends Node

var _current_level: BaseLevel

func _ready() -> void:
	load_level(GameManager.current_level)
	_current_level.level_completed.connect(_on_level_completed)


func load_level(level: int) -> void:
	if _current_level:
		_current_level.queue_free()

	var path := "res://Levels/Level%d/level.tscn" % level
	var scene := load(path) as PackedScene
	_current_level = scene.instantiate()
	add_child(_current_level)
	

func _on_level_completed() -> void:
	GameManager.current_level += 1
	load_level(GameManager.current_level)
