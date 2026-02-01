extends Area2D
class_name EnemyChaseAI

@export var character: CharacterBody2D
@export var speed: float = 30.0
@export var sprite : AnimatedSprite2D = null

var target: Node2D = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null

func _physics_process(delta: float) -> void:
	if target == null:
		character.velocity.x = 0
		return

	var dir: float = sign(target.global_position.x - character.global_position.x)
	character.velocity.x = dir * speed
	if sprite:
		if dir == 1:
			sprite.flip_h = false
		elif dir == -1:
			sprite.flip_h = true
	
