extends CharacterBody2D

@export var speed = 200.0
var tinta = 100
var immovil = false
var tiempo_espera = 3

func _physics_process(delta):
	print(tinta)
	var direccion: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if immovil == false:
		velocity = direccion * speed
		move_and_slide()
		if velocity.x > 0:
			$AnimatedSprite2D.play("Move Right")
		elif velocity.x < 0:
			$AnimatedSprite2D.play("Move Left")
		elif velocity.x == 0 and velocity.y == 0:
			$AnimatedSprite2D.play("Normal")
		
	if Input.is_action_just_pressed("Shoot") and tinta > 0:
		tinta -= 1
	


func _on_bombona_cent_body_entered(body: Node2D):
	if body.name == "Player":
		if tinta == 0:
			$"../CanvasLayer/Control/Bombona".play("Carga_V")
			tinta = 100
			$AnimatedSprite2D.play("Change")
			immovil = true
			$Carga.wait_time = tiempo_espera 
			$Carga.start()
		elif tinta > 0 and tinta < 25:
			$"../CanvasLayer/Control/Bombona".play("Carga_1")
			tinta = 100
			immovil = true
			$Carga.wait_time = tiempo_espera *3/4
			$Carga.start()
			
		elif tinta > 25 and tinta < 50:
			$"../CanvasLayer/Control/Bombona".play("Carga_2")
			tinta = 100
			immovil = true
			$Carga.wait_time = tiempo_espera *2/4
			$Carga.start()
		elif tinta > 50 and tinta < 75:
			$"../CanvasLayer/Control/Bombona".play("Carga_3")
			tinta = 100
			immovil = true
			$Carga.wait_time = tiempo_espera /4
			$Carga.start()
			


func _on_carga_timeout():
	immovil = false
