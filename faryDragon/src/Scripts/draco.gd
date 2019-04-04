extends KinematicBody2D

var ptos_vida = 10
var ptos_vida_max = 10
var velocidade = Vector2(0,0)
var velocidade_atual = Vector2(0,0)

var estado_atual = 0
var estado_anterior = 0
var estado_lista = {
	"parado"   : 0,
	"andando"  : 1,
	"correndo" : 2,
	"pulando"  : 3,
	"planando" : 4,
	"voando"   : 5,
	"nadando"  : 6
}
var comportamento = {
	"terrestre" : 0,
	"aereo"     : 1,
	"aquatico"  : 2
}

func _ready():
	pass
	
	
func get_ptos_vida():
	return self.ptos_vida
	
	
func get_ptos_vida_max():
	return self.ptos_vida_max
	
	
#warning-ignore:unused_argument
func _process(dt):
	verifica_entradas()

func verifica_entradas():
	if (Input.is_action_just_pressed("ui_space")):
		if (estado_atual < estado_lista.pulando):
			velocidade.y = -800
			set_estado(estado_lista.pulando)
		elif (estado_atual == estado_lista.pulando):
			velocidade.y = -600
			set_estado(estado_lista.planando)
		elif (estado_atual == estado_lista.planando):
			set_estado(estado_lista.pulando)
		
		
	if Input.is_action_pressed("ui_right"):
		velocidade.x += globais.vel_horizontal
		$Sprite.set_flip_h(false)
		
		
	if Input.is_action_pressed("ui_left"):
		velocidade.x -= globais.vel_horizontal
		$Sprite.set_flip_h(true)
		
		
	if Input.is_action_just_released("ui_right"):
		velocidade.x = 0
		
		
	if Input.is_action_just_released("ui_left"):
		velocidade.x = 0
		
		
	if Input.is_action_just_pressed("key_d"):
		aplica_dano(1)
		
		
func _physics_process(dt):
	if (velocidade.x > 0):
		if (velocidade.x > globais.vel_terminal.x):
			velocidade.x = globais.vel_terminal.x
		else:
			velocidade.x -= 250*dt
	elif (velocidade.x < 0):
		print("Vel menor que 0 ", velocidade.x)
		if (abs(velocidade.x) > globais.vel_terminal.x):
			velocidade.x = -1*globais.vel_terminal.x
		else:
			velocidade.x += 250*dt
			
	if (estado_atual == estado_lista.voando):
		pass
		
	elif (estado_atual == estado_lista.planando):
		velocidade.y += globais.gravidade * 3/4
		if (velocidade.y > 40):
			velocidade.y = 40
	else:
		velocidade.y += globais.gravidade
		
	set_velocidades()
	
	
func set_velocidades():
	velocidade.normalized()
	velocidade_atual = move_and_slide(velocidade, Vector2(0, -1), true, 5)
	velocidade = velocidade_atual
	print(velocidade_atual, estado_atual)
	
	if (estado_atual >= estado_lista.pulando && is_on_floor()):
		set_estado(estado_lista.parado)
		
	if (estado_atual <= estado_lista.correndo):
		if (abs(velocidade_atual.x) > (globais.vel_terminal.x *2/3 )):
			set_estado(estado_lista.correndo)
		else:
			set_estado(estado_lista.andando)
			
		if (velocidade_atual.x == 0):
			set_estado(estado_lista.parado)
	
	 
func set_estado (estado):
	if (estado_atual != estado):
		estado_anterior = estado_atual
		estado_atual    = estado
		verifica_estados()
	
	
func verifica_estados():
	match (estado_atual):
		estado_lista.parado:
			parar()
		estado_lista.andando:
			andar()
		estado_lista.pulando:
			pular()
		estado_lista.planando:
			planar()
		estado_lista.voando:
			voar()
	
	
func aplica_dano(dano):
	self.ptos_vida -= dano
	if (self.ptos_vida < 0):
		self.ptos_vida = 0
	
	
func andar():
	print("andando")
	$Animation.play("walk")
	
	
func correr():
	print ("correndo")
	$Animation.play("run")
	
	
func parar():
	print ("parando")
	$Animation.play("idle")
	
	
func planar():
	print ("planando")
	$Animation.play("fly")
	
	
func voar():
	print ("voando")
	$Animation.play("fly")
	
	
func pular():
	print ("pulando")
	$Animation.play("jump")