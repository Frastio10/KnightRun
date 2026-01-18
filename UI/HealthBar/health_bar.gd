extends Control

@export var health_component : HealthComponent
@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	progress_bar.value = health_component.current_health
	progress_bar.visible = health_component.current_health < health_component.max_health 
	health_component.health_updated.connect(_on_update_health)

func _on_update_health(health: int, _prev_health: int, _max_health: int) -> void:
	if(health == health_component.max_health):
		progress_bar.visible = false
	else:
		progress_bar.visible = true
	 
	progress_bar.value = health
