extends CharacterBody2D

@export var speed: float = 400
@export var anim_player: AnimatedSprite2D
	
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	update_sprite()
	
	move_and_slide()

func update_sprite():
	if velocity.length() > 0:
		anim_player.play("run")
	else:
		anim_player.play("idle")
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
