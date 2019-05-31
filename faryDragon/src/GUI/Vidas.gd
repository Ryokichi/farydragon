extends HBoxContainer

var vida_array = [$Vida1, $Vida2, $Vida3, $Vida4, $Vida5]
var vida_ativa = [true, true, true, true, true]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func atualiza_vida(vida):
	if (vida < 0):
		return
	$AtualizarVida.play(str(vida)+"_vida")