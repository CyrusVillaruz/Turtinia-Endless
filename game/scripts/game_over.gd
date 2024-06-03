extends CenterContainer

@onready var retry_button = %RetryButton
@onready var quit_button = %QuitButton
@onready var level_reached_text = %LevelReachedText

func _ready():
	Events.update_highest_level_text.connect(update_level_reached_text)

func update_level_reached_text(level):
	level_reached_text.text = str("Level Reached: ", level)

func _on_quit_button_pressed():
	await LevelTransition.fade_in()
	get_tree().quit()

func _on_retry_button_pressed():
	await LevelTransition.fade_in()
	get_tree().change_scene_to_file("res://game/scenes/levels/level.tscn")
	LevelTransition.fade_out()
