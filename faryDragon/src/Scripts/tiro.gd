extends Node2D

var vel = 500
var ini_pos = Vector2(0,0)

func _ready():
	set_process(true)
	ini_pos = get_global_position()
	pass # Replace with function body.

func _process(delta):
	set_global_position(get_global_position() + Vector2(1,0)*vel*delta)
	
	if get_global_position().x > globais.window.width +100 :
		self.destroi()
		pass

func destroi():
	queue_free()
	print("menos um tiro")
	

func _on_Area2D_area_entered(area):
	if (area.has_method("get_tipo")):
		if (area.get_tipo() == "inimigo"):
			print(area.get_parent().dano(1))
			self.destroi()
	pass # Replace with function body.
