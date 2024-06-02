extends Node2D

func spawn_enemy():
	var enemy = preload("res://game/scenes/enemy/skeleton.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy.global_position = %PathFollow2D.global_position
	add_child(enemy)

func _on_spawn_timer_timeout():
	spawn_enemy()
