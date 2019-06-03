extends Node2D

var vel = 500
var ini_pos = Vector2(0,0)
var cur_pos = Vector2(0,0)
var dist_perc;
var player;

func _ready():
	set_process(true)
	ini_pos = get_global_position()
	player = get_node("../Draco")
	vel = vel * player.orientacao.x
	
	if (player.orientacao.x == -1):
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false

func _process(delta):
	set_global_position(get_global_position() + Vector2(1,0)*vel*delta)
	dist_perc = abs(get_global_position().x - ini_pos.x)
	
	if (dist_perc > 1200):
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
