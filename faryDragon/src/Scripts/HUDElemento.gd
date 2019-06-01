extends Control

var elemento_atual = 0
var elemento_lista = []
var elemento_lista_nova = []

var pos_ref = Vector2(213, 50)


func _ready():
	elemento_lista = [$Neutro, $Fogo, $Terra, $Agua, $Vento]
	self.rotacionaElelementos()

func _process(delta):
	if Input.is_action_just_pressed("ui_lb"):
		self.trocaElemento("l")
	if Input.is_action_just_pressed("ui_rb"):
		self.trocaElemento("r")

func trocaElemento(lado):
	elemento_lista_nova.clear()
		
	if (lado == "l"):
		elemento_lista_nova.append(elemento_lista[elemento_lista.size() - 1])
		for i in range(0, elemento_lista.size() -1):
			elemento_lista_nova.append(elemento_lista[i])
		
	elif (lado == "r"):
		for i in range(1, elemento_lista.size()):
			elemento_lista_nova.append(elemento_lista[i])
			
		elemento_lista_nova.append(elemento_lista[0])
	
	for i in range(elemento_lista_nova.size()):
		elemento_lista[i] = elemento_lista_nova[i]
		
	self.rotacionaElelementos()
	
func tweenRotacao(obj, pos_fim, escala_fim):
	var pos_ini    = obj.position
	var escala_ini = obj.scale
	
	$Tween.interpolate_property(obj, "position", pos_ini, pos_fim, 0.2, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
	$Tween.interpolate_property(obj, "scale", escala_ini, escala_fim, 0.2, Tween.TRANS_EXPO, Tween.EASE_IN, 0)
	$Tween.start()
	pass
	
func rotacionaElelementos():
	var pos_ini
	var pos_fim
	var escala
	
	pos_ini = elemento_lista[0].position
	pos_fim = pos_ref
	escala  = Vector2(0.3, 0.3)
	elemento_lista[0].z_index  = 3
	self.tweenRotacao(elemento_lista[0], pos_fim, escala)
	
	pos_ini = elemento_lista[1].position
	pos_fim = Vector2(pos_ref.x+50, pos_ref.y-40)
	escala  = Vector2(0.2, 0.2)
	elemento_lista[1].z_index  = 2
	self.tweenRotacao(elemento_lista[1], pos_fim, escala)
	
	pos_ini = elemento_lista[2].position
	pos_fim = Vector2(pos_ref.x+25, pos_ref.y-75)
	escala  = Vector2(0.15, 0.15)
	elemento_lista[2].z_index  = 1
	self.tweenRotacao(elemento_lista[2], pos_fim, escala)
	
	pos_ini = elemento_lista[3].position
	pos_fim = Vector2(pos_ref.x-25, pos_ref.y-75)
	escala  = Vector2(0.15, 0.15)
	elemento_lista[3].z_index  = 1
	self.tweenRotacao(elemento_lista[3], pos_fim, escala)
	
	pos_ini = elemento_lista[4].position
	pos_fim = Vector2(pos_ref.x-50, pos_ref.y-40)
	escala  = Vector2(0.2, 0.2)
	elemento_lista[4].z_index  = 2
	self.tweenRotacao(elemento_lista[4], pos_fim, escala)

func _on_Tween_tween_completed(object, key):
	print(object, key)
	pass # Replace with function body.
