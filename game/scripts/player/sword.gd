extends Node2D

@export var damage: float = 1.0
@onready var animation_player = $AnimationPlayer

func swing_sword():
	animation_player.play("swing")

func _on_area_2d_body_entered(body):
	pass # Replace with function body.
