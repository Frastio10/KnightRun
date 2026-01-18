extends Area2D
class_name CollectibleComponent

signal collected(collector: Node)

@export var points := 1
@export var auto_destroy := true

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	#if not body.is_in_group("player"):
		#return

	collected.emit(body)

	if auto_destroy:
		get_parent().queue_free()
