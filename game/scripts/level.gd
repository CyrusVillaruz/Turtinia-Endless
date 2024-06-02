extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var wave_label = $WaveUI/WaveLabel
@onready var wave_progress_bar = $WaveUI/WaveProgressBar

var current_level = 0
var current_xp = 0
var xp_to_next_level = 500
var xp_to_next_level_multiplier = 1.5
var current_spawn_rate = 5.0
var max_spawn_rate = 0.2

func _ready():
	Events.update_xp.connect(add_xp)
	Events.player_dead.connect(game_over)

func _physics_process(delta):
	wave_label.text = str("Level ", current_level)
	wave_progress_bar.value = current_xp
	wave_progress_bar.max_value = xp_to_next_level
	spawn_timer.wait_time = current_spawn_rate
	
	if current_xp >= xp_to_next_level:
		current_level += 1
		current_xp = 0
		xp_to_next_level *= xp_to_next_level_multiplier
		current_spawn_rate = max(current_spawn_rate - 0.2, max_spawn_rate)

func spawn_enemy():
	var enemy = preload("res://game/scenes/enemy/skeleton.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy.global_position = %PathFollow2D.global_position
	add_child(enemy)

func add_xp(amount):
	current_xp += amount

func game_over():
	pass

func _on_spawn_timer_timeout():
	spawn_enemy()
