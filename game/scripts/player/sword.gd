extends Node2D

@export var damage: float = 1.0
@onready var animation_player = $AnimationPlayer

func _ready():
	$Sprite2D.visible = false

func swing_sword():
	animation_player.play("swing")

func _on_area_2d_body_entered(body):
	body.enemy_damaged.emit(damage)
