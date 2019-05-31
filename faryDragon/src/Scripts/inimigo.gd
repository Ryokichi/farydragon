extends KinematicBody2D

export(int,1,10) var vida = 1
var vivo = true

var tipo = "inimigo"

func _ready():
	pass # Replace with function body.

func get_tipo():
	return tipo
	

func dano(qtd):
	if !vivo:
		return
	vida -= qtd
	if vida <= 0:
		vivo = false
		get_node("shape").queue_free()
		queue_free()
