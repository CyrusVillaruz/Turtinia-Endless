extends CharacterBody2D

signal player_dead

@export var speed: float = 100
@export var health: float = 100.0
@export var anim_player: AnimatedSprite2D

const DAMAGE_RATE = 2.0

func _ready():
	%HealthBar.value = health
	
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	update_sprite()
	move_and_slide()
	
	var collided_enemies = %Hurtbox.get_overlapping_bodies()
	
	if collided_enemies.size() > 0:
		health -= DAMAGE_RATE * collided_enemies.size() * delta
		$HealthBar.value = health
		if health <= 0:
			player_dead.emit()

func update_sprite():
	if velocity.length() > 0:
		anim_player.play("run")
	else:
		anim_player.play("idle")
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
