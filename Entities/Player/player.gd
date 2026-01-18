extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var died_timer: Timer = $DiedTimer

signal died

enum AnimPriority {
	BASE = 0,
	MOVEMENT = 1,
	ACTION = 2,
	HIT = 3,
	DEATH = 4
}

var current_anim_priority := AnimPriority.BASE

const sfx_jump = preload("res://Entities/Player/jump.wav")
const sfx_hurt = preload("res://Entities/Player/hurt.wav")
const sfx_explosion = preload("res://Entities/Player/explosion.wav")

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const JUMP_CUT_MULTIPLIER = 0.35

const MAX_JUMP = 2
var jump_count := 0

func _ready() -> void:
	health_component.connect("health_updated", _player_health_updated)
	health_component.connect("died", _player_died)
	animated_sprite.animation_finished.connect(_on_anim_end)
	died_timer.timeout.connect(_on_died_timer_timeout)
	
func _on_anim_end() -> void:
	current_anim_priority = AnimPriority.BASE

func play_sfx(stream: AudioStream) -> void:
	audio.stop()
	audio.stream = stream
	audio.play()

func play_anim(anim_name: String, priority: int = AnimPriority.BASE) -> void:
	if priority < current_anim_priority:
		return

	if animated_sprite.animation != anim_name:
		current_anim_priority = priority as AnimPriority
		animated_sprite.play(anim_name)

func _player_died() -> void: 
	velocity.y = JUMP_VELOCITY
	play_sfx(sfx_explosion)
	collision_shape.queue_free()
	died_timer.start()
	
func _player_hurt(): 
	play_sfx(sfx_hurt)
	play_anim("hit", AnimPriority.HIT)
	
func _player_health_updated(health: int, prev_health: int, _max_health: int) -> void:
	if health < prev_health: 
		_player_hurt()

func _on_died_timer_timeout() -> void:
	emit_signal("died")

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)

	# Reset jump when landing
	if is_on_floor() and jump_count > 0:
		jump_count = 0

	# Jump 
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP:
		jump_count += 1
		play_sfx(sfx_jump)
		velocity.y = JUMP_VELOCITY

		if jump_count > 1:
			play_anim("roll", AnimPriority.ACTION)
		else:
			play_anim("jump")

	# Variable jump height
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= JUMP_CUT_MULTIPLIER

	# Horizontal input
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite
	if direction != 0:
		animated_sprite.flip_h = direction < 0

	if not is_on_floor():
		play_anim("jump")
	elif direction == 0:
		play_anim("idle")
	else:
		play_anim("move")

	move_and_slide()
	
	
	
