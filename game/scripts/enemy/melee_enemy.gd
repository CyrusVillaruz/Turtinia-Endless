extends CharacterBody2D

signal enemy_damaged(amount)

@export var speed: float = 70.0
@export var health: float = 5.0
@export var xp_amount: float = 200.0

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
		Events.update_xp.emit(xp_amount)
		queue_free()
	
	animated_sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	animated_sprite_2d.modulate = Color.WHITE

func update_animation(direction):
	animated_sprite_2d.play("run")
	animated_sprite_2d.flip_h = direction.x < 0
