extends Control

@onready var play_button: Button = $PlayButton

func _ready() -> void:
	play_button.pressed.connect(_on_click_play)
	
func _on_click_play()-> void:
	GameManager.set_state(GameManager.State.INGAME)
	print("playyy")
	pass
