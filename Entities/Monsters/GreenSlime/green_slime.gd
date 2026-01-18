extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	move_and_slide()
