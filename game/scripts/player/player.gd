extends CharacterBody2D

@export var speed: float = 100.0
@export var health: float = 100.0
@export var anim_player: AnimatedSprite2D

@onready var sword = $Sword
@onready var animated_sprite_2d = $AnimatedSprite2D

const DAMAGE_RATE = 2.0

func _ready():
	%HealthBar.value = health
	
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	update_animations()
	move_and_slide()
	
	var collided_enemies = %Hurtbox.get_overlapping_bodies()
	
	if collided_enemies.size() > 0:
		health -= DAMAGE_RATE * collided_enemies.size() * delta
		$HealthBar.value = health
		if health <= 0:
			Events.player_dead.emit()

func update_animations():
	if velocity.length() > 0:
		anim_player.play("run")
	else:
		anim_player.play("idle")
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = get_global_mouse_position().x < global_position.x
		sword.position = Vector2(-7, 2) if animated_sprite_2d.flip_h else Vector2(7, 2)
		sword.scale = Vector2(-1, 1) if animated_sprite_2d.flip_h else Vector2(1, 1)
	
	if Input.is_action_just_pressed("attack"):
		sword.swing_sword()
