extends Node2D

func _ready():
	var player = preload("res://game/scenes/player/player.tscn").instantiate()
	add_child(player)
