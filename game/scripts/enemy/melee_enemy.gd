extends CharacterBody2D

signal enemy_damaged(amount)

@export var speed: float = 50.0
@export var health: float = 5.0

@onready var player = get_node("/root/Level/Player")
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	enemy_damaged.connect(take_damage)

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	update_animation(direction)
	move_and_slide()

func take_damage(amount):
	health -= amount
	velocity = Vector2.ZERO
	if health <= 0:
		queue_free()

func update_animation(direction):
	animated_sprite_2d.play("run")
	animated_sprite_2d.flip_h = direction.x < 0
