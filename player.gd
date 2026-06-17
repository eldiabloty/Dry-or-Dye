extends CharacterBody2D

@export var speed = 200.0

func _physics_process(delta):
	var direccion: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direccion * speed
	move_and_slide()
	if velocity.x > 0:
		$AnimatedSprite2D.play("Move Right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("Move Left")
	else:
		$AnimatedSprite2D.play("Normal")
