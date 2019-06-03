extends Node

onready var player = $Draco
onready var barra_vida = $GUILayer/GUI/BarraVida/Barra
onready var marcador_vida = $GUILayer/GUI/BarraVida/Contador/Texto
onready var hud_vidas = $GUILayer/GUI/HUD/Vidas



func _ready():
	barra_vida.set_max(player.vida_max)
	marcador_vida.text = str(player.vida_atual) + "/" + str(player.vida_max)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_d"):
		player.toma_dano(1)		
		
	barra_vida.value = player.vida_atual
	marcador_vida.text = str(player.vida_atual) + "/" + str(player.vida_max)
	
