extends Node


func _ready():
	globais._ready()
	$cam1.make_current()
	pass

func _process(delta):
	if Input.action_press("ui_up"):
		print($cam1.get_global_position())
	pass


func move_cam (ini, end):
	$Tween.interpolate_property($cam1, "position", ini, end, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, 0)
	$Tween.start()
	pass
	
func _on_btn_options_up():	
	var ini = $cam1.get_global_position()
	var end = Vector2(640*3, 360)
	self.move_cam(ini, end)
	pass
	
func _on_btn_credits_up():
	var ini = $cam1.get_global_position()
	var end = Vector2(-640, 360)
	self.move_cam(ini, end)
	pass

func _on_btn_back2_up():
	var ini = $cam1.get_global_position()
	var end = Vector2(640, 360)
	self.move_cam(ini, end)
	pass

func _on_btn_back1_up():
	var ini = $cam1.get_global_position()
	var end = Vector2(640, 360)
	self.move_cam(ini, end)
	pass

func _on_btn_start_up():
	get_tree().change_scene("res://src/Scenes/stage01.tscn")
	pass