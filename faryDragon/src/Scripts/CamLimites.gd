extends Node2D

onready var player    = get_node('../Draco');
onready var player_cp  = get_node('../Draco/CenterPoint');

var orientacao_nova   = Vector2(0,0)
var orientacao_antiga = Vector2(0,0)
var seguir_player = false
var dentro_do_centro = false
var window_size = Vector2(globais.window.width, globais.window.height)


func _ready():
	$CentArea.position.x = 0	
	$EsqArea.position.x = window_size.x * -0.5
	$DirArea.position.x = window_size.x * 0.5
	$CentArea/CollBox.shape.set_extents(Vector2(window_size.x * 0.20,window_size.y*2))
	$EsqArea/CollBox.shape.set_extents(Vector2(window_size.x * 0.10,window_size.y*2))
	$DirArea/CollBox.shape.set_extents(Vector2(window_size.x * 0.10,window_size.y*2))


func _process(delta):
	$Cam.global_position = self.global_position
	if (orientacao_nova.x != player.orientacao.x):
		seguir_player = false
	
	if (seguir_player == true):
		update_da_posicao(player.orientacao.x)
		
#	elif (dentro_do_centro == true):
#		update_da_posicao(orientacao_antiga.x)
	
	orientacao_antiga = orientacao_nova
	self.global_position.y = player.global_position.y ####Verificar regra pos Y
	pass


func update_da_posicao (lado):
	self.global_position.x = player.global_position.x + (window_size.x * 0.20 * lado)


#Orientacao do corpo pode ter valores 1 ou -1 apenas
#Indica para qual lado o plyer está olhando
func _on_CentArea_area_entered(area):	
	if (area != player_cp):
		return
		
	seguir_player = true
	dentro_do_centro = true
	orientacao_nova.x = player.orientacao.x
	update_da_posicao(player.orientacao.x)


func _on_CentArea_area_exited(area):
	dentro_do_centro = false

func _on_EsqArea_area_entered(area):
	if (area != player_cp):
		return
		
	seguir_player = true
	orientacao_nova.x = player.orientacao.x
	update_da_posicao(player.orientacao.x)


func _on_DirArea_area_entered(area):
	if (area != player_cp):
		return
		
	seguir_player = true
	orientacao_nova.x = player.orientacao.x
	update_da_posicao(player.orientacao.x)