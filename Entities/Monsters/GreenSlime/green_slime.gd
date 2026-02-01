extends CharacterBody2D

@onready var raycast_left: RayCast2D = $RayCastLeft
@onready var raycast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 30.0

var direction = 1

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	
	if abs(velocity.x) < 1.0:
		direction = -1 if animated_sprite.flip_h else 1
		if raycast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		if raycast_left.is_colliding():
			direction = 1	
			animated_sprite.flip_h = false 
		
		velocity.x = direction * SPEED
	
	move_and_slide()
