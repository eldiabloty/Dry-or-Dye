extends CharacterBody2D

@export var speed = 300.0
var speed_normal = 300
var speed_red = 150
var speed_chetada = 300 *1.15
var tinta = 100
var immovil = false
var tiempo_espera = 3
@export var animal = 2
var animal_inicial = 2
var ulti = 0
@onready var tilemap = $"../../TileMap"
const ID_BALDOSA_AZUL = 0
var necesito = true


func _physics_process(delta):
	var direccion: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if immovil == false:
		velocity = direccion * speed
		move_and_slide()
		if velocity.x > 0 and animal == 0:
			$"Animacion Homunculo".play("Move Right (Hom)")
		elif velocity.x < 0 and animal == 0:
			$"Animacion Homunculo".play("Move Left (Hom)")
		elif velocity.x == 0 and velocity.y == 0 and animal == 0:
			$"Animacion Homunculo".play("Normal (Hom)")
		if velocity.x == 0 and velocity.y == 0 and animal == 2:
			$"Animacion Leo".play("Normal (Leo)")
		elif velocity.x != 0 or velocity.y != 0 and animal == 2:
			$"Animacion Leo".play("Move (Leo)")
		
	if Input.is_action_just_pressed("Shoot") and tinta > 0:
		tinta -= 1
	if tinta == 0:
		speed = speed_red
		animal = 0
	if tinta == 100:
		speed = speed_normal
		animal = animal_inicial
	if animal != 0:
		$"Animacion Homunculo".hide()
	else:
		$"Animacion Homunculo".show()
	if animal != 2:
		$"Animacion Leo".hide()
	else:
		$"Animacion Leo".show()
		if Input.is_action_just_pressed("Ultimate"):
			ulti = 2
	
	if ulti == 2:
		ulti_leo()

func ulti_leo():
	if velocity != Vector2.ZERO and ulti != 0:
		if necesito == true:
			speed = speed_chetada
			$Leo.start()
			print("Start")
			necesito = false
		else:
			print("Variable")
		
		# Convertimos la posición global del jugador a la coordenada de la cuadrícula
		var mitad_baldosa = 32 
		var posicion_local = tilemap.to_local(global_position + Vector2(0, mitad_baldosa))
		var posicion_celda = tilemap.local_to_map(posicion_local)
		# Pintamos esa celda de color azul
		# Nota: Si usas Godot 4.3+, asegúrate de si usas 'set_cell(posicion_celda, ID_BALDOSA_AZUL)'
		# Si usas capas (layers), el primer parámetro suele ser la capa, ej: set_cell(0, posicion_celda, ID_BALDOSA_AZUL, Vector2i(0,0))
		tilemap.set_cell(0, posicion_celda, ID_BALDOSA_AZUL, Vector2i(0, 0))



func _on_bombona_cent_body_entered(body: Node2D):
	if body.name == "Player":
		if tinta == 0:
			$"../CanvasLayer/Control/Bombona".play("Carga_V")
			$"Animacion Homunculo".play("Change")
			immovil = true
			$Carga.wait_time = tiempo_espera 
			$Carga.start()
		elif tinta > 0 and tinta < 25:
			$"../CanvasLayer/Control/Bombona".play("Carga_1")
			immovil = true
			$Carga.wait_time = tiempo_espera *3/4
			$Carga.start()
			
		elif tinta > 25 and tinta < 50:
			$"../CanvasLayer/Control/Bombona".play("Carga_2")
			immovil = true
			$Carga.wait_time = tiempo_espera *2/4
			$Carga.start()
		elif tinta > 50 and tinta < 75:
			$"../CanvasLayer/Control/Bombona".play("Carga_3")
			immovil = true
			$Carga.wait_time = tiempo_espera /4
			$Carga.start()
			


func _on_carga_timeout():
	immovil = false
	tinta = 100
	if $Carga.wait_time == tiempo_espera:
		animal = 0


func _on_leo_timeout():
	ulti = 0
	speed = speed_normal
	print("Funciono")
	necesito =true
