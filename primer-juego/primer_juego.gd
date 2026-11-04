
extends Node

var score = 0
var velocidad = 240.0
var direccion = 1

var ancho_pantalla = 1152
var alto_pantalla = 648

func _ready() -> void:
	randomize()
	$Label.text = "Puntos: 0"
	$estrella.position = Vector2(
		randf_range(50, ancho_pantalla - 50),
		randf_range(50, alto_pantalla - 50)
	)


func _process(delta: float) -> void:

	# Portales en los extremos
	if $personaje.position.x > ancho_pantalla:
		$personaje.position.x = 0

	if $personaje.position.x < 0:
		$personaje.position.x = ancho_pantalla

	# Movimiento con flechas
	if Input.is_action_pressed("ui_up"):
		$personaje.position.y -= velocidad * delta

	if Input.is_action_pressed("ui_down"):
		$personaje.position.y += velocidad * delta
		
	if Input.is_action_pressed("ui_left"):
		$personaje.position.x -= velocidad * delta

	if Input.is_action_pressed("ui_right"):
		$personaje.position.x += velocidad * delta

	# Evitar salir verticalmente
	$personaje.position.y = clamp(
		$personaje.position.y,
		0,
		alto_pantalla
	)

	# Detectar cuando recoge la estrella
	if $personaje.position.distance_to($estrella.position) < 40:
		score += 1
		$Label.text = "Puntos: " + str(score)

		# Reubicar estrella aleatoriamente
		$estrella.position = Vector2(
			randf_range(50, ancho_pantalla - 50),
			$personaje.position.y
		)

		# Desafío opcional
		if score == 5:
			velocidad += 100

		# Mensaje al alcanzar 10 puntos
		if score >= 10:
			$Label.text = "¡Felicidades! Conseguiste 10 puntos"
