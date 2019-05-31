extends Area2D

var tipo = "inimigo"

func _ready():
	pass # Replace with function body.

func set_tipo(tipo):
	self.tipo = tipo

func get_tipo():
	return self.tipo