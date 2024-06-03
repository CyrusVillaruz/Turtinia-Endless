extends ColorRect

@onready var retry_button = %RetryButton
@onready var quit_button = %QuitButton

func _on_quit_button_pressed():
	await LevelTransition.fade_in()
	get_tree().quit()

func _on_retry_button_pressed():
	await LevelTransition.fade_in()
	get_tree().change_scene_to_file("res://game/scenes/levels/level.tscn")
	LevelTransition.fade_out()
