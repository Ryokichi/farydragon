extends Control

var elemento_atual = 0
var elemento_lista


func _ready():
	elemento_lista = [$Neutro, $Fogo, $Terra, $Agua, $Vento]
	for i in range(elemento_lista.size()) :
		elemento_lista[i].scale = Vector2(0.2, 0.2)
	
	var pos = Vector2(213, 50)
	elemento_lista[0].position = Vector2(pos.x, pos.y)
	elemento_lista[0].scale = Vector2(0.3, 0.3)
	elemento_lista[0].z_index  = 3
	elemento_lista[1].position = Vector2(pos.x+50, pos.y-50)
	elemento_lista[1].z_index  = 2
	elemento_lista[2].position = Vector2(pos.x+25, pos.y-75)
	elemento_lista[2].scale = Vector2(0.15, 0.15)
	elemento_lista[2].z_index  = 1
	elemento_lista[3].position = Vector2(pos.x-25, pos.y-75)
	elemento_lista[3].scale = Vector2(0.15, 0.15)
	elemento_lista[3].z_index  = 1
	elemento_lista[4].position = Vector2(pos.x-50, pos.y-50)
	elemento_lista[4].z_index  = 2


func _process(delta):
	if Input.is_action_just_pressed("ui_lb"):
		self.trocaElemento("l")
	if Input.is_action_just_pressed("ui_rb"):
		self.trocaElemento("r")

func trocaElemento(lado):
	if (lado == "l"):
		elemento_atual -= 1
	elif (lado == "r"):
		elemento_atual += 1
	