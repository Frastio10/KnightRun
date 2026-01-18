extends Node

var _current_level: BaseLevel

func _ready() -> void:
	load_level(GameManager.current_level)


func _on_restart_level() -> void:
	call_deferred("load_level", GameManager.current_level)

func load_level(level: int) -> void:
	print("Loading Level: ", level)
	if _current_level:
		_current_level.queue_free()

	var path := "res://Levels/Level%d/level.tscn" % level
	var scene := load(path) as PackedScene
	_current_level = scene.instantiate()
	call_deferred("add_child", _current_level)
	
	_current_level.level_completed.connect(_on_level_completed)
	_current_level.restart_level.connect(_on_restart_level)
	

func _on_level_completed(data: Dictionary) -> void:
	GameManager.add_score(GameManager.current_level, data)
	GameManager.current_level += 1
	load_level(GameManager.current_level)
	call_deferred("load_level", GameManager.current_level)
