extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$GameHud/Interface.updateVidaMax($Draco.get_ptos_vida_max())
	$GameHud/Interface.updateVida($Draco.get_ptos_vida())
	pass

func _process(delta):
	$GameHud/Interface.updateVida($Draco.get_ptos_vida())
	pass
