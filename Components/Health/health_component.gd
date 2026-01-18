extends Node
class_name HealthComponent

@onready var regen_timer: Timer = $RegenTimer

signal died
signal health_updated(current, previous, max)

@export var max_health := 100
var current_health := 100
var is_dead := false

func _ready() -> void:
	current_health =  max_health
	is_dead = false
	emit_signal("health_updated", current_health, current_health, max)
	regen_timer.timeout.connect(_on_regen_timer_timeout)
	
func _on_regen_timer_timeout() -> void:
	heal(10)
	
func take_damage(damage: int) -> void:
	if damage  <= 0:
		return
	regen_timer.stop()
	regen_timer.start()
	var prev_health := current_health
	current_health -= damage
	current_health = max(current_health, 0)
	emit_signal("health_updated", current_health, prev_health, max_health)

	if current_health == 0 and not is_dead:
		is_dead = true
		emit_signal("died")
		

func heal(amount: int) -> void:
	if amount <= 0:
		return
	var prev_health := current_health
	current_health += amount
	current_health = min(current_health, max_health)
	emit_signal("health_updated", current_health, prev_health ,max_health)
