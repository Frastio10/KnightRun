extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collectible_component: CollectibleComponent = $CollectibleComponent

@export var point := 1
	
func _ready() -> void:
	collectible_component.collected.connect(_on_collected)
	
func _on_collected(_collector: Node) -> void:
	animation_player.play("collect")
	var level := get_tree().get_first_node_in_group("level") as BaseLevel
	level.add_score(point)
