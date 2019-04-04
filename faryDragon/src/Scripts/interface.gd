extends Control

var vida_max = 1

func _ready():
	$VidaFrame.apply_scale(Vector2(0.5, 0.5))
	
func updateVidaMax(vida_max):
	self.vida_max = vida_max
	
func updateVida(vida_atual):
	var vida_percent = vida_atual / self.vida_max
	$VidaFrame/VidaBarra.apply_scale(Vector2(vida_percent, 1))