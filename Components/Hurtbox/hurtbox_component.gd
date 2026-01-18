extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent

func _ready():
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	print("killingg")
	if area is HitboxComponent:
		_take_hit(area)
		
func _take_hit(area: HitboxComponent) -> void:
	health_component.take_damage(area.damage)
