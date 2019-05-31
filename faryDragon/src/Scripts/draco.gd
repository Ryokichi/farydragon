extends KinematicBody2D

var velocidade = Vector2(0, 0)
var velocidade_atual = Vector2(0, 0)
var orientacao = Vector2(1, 0)
var vida_max = 5
var vida_atual = vida_max

var delay_dano = 0
var modulate_on = false

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
	"aquatico"  : 2}

func _ready():
	pass
	
func _process(dt):
	if (delay_dano > 0):
		delay_dano -= dt
		
	if (Input.is_action_just_pressed("ui_space")):
		if (estado_atual < estado_lista.pulando):
			velocidade.y = -800
			set_estado(estado_lista.pulando)
		elif (estado_atual == estado_lista.pulando):
			velocidade.y = -600
			set_estado(estado_lista.planando)
		elif (estado_atual == estado_lista.planando):
			set_estado(estado_lista.pulando)
		pass
		
	if Input.is_action_pressed("ui_right"):
		orientacao.x = 1
		velocidade.x += globais.vel_horizontal
#		$Sprite.set_flip_h(false)
		$Sprite.scale.x = 1
		pass
		
	if Input.is_action_pressed("ui_left"):
		orientacao.x = -1
		velocidade.x -= globais.vel_horizontal
#		$Sprite.set_flip_h(true)
		$Sprite.scale.x = -1
		pass
		
		
func _physics_process(dt):
	if (velocidade.x > 0):
		if (velocidade.x > globais.vel_terminal.x):
			velocidade.x = globais.vel_terminal.x
		else:
			velocidade.x -= globais.diminuicao_vel_h*dt
	elif (velocidade.x < 0):
#		print("Vel menor que 0 ", velocidade.x)
		if (abs(velocidade.x) > globais.vel_terminal.x):
			velocidade.x = -1*globais.vel_terminal.x
		else:
			velocidade.x += globais.diminuicao_vel_h*dt
			
	if (estado_atual == estado_lista.voando):
		pass
	elif (estado_atual == estado_lista.planando):
		velocidade.y += globais.gravidade * 3/4
		if (velocidade.y > globais.queda_planagem):
			velocidade.y = globais.queda_planagem
	else:
		velocidade.y += globais.gravidade
		
	if (velocidade.y > globais.vel_terminal.y):
		velocidade.y = globais.vel_terminal.y
		
	set_velocidades()
	
	
func set_velocidades():
	if (velocidade.x > -1 && velocidade.x < 1):
		velocidade.x = 0
		
	velocidade.normalized()
	velocidade_atual = move_and_slide(velocidade, Vector2(0, -1), true, 3, 0.78, false)
	velocidade = velocidade_atual
#	print(velocidade_atual, estado_atual)
	
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
	pass
	
func toma_dano (dano):
	if (delay_dano > 0):
		return
		
	vida_atual -= dano
	delay_dano = 1.5
	$Piscar.start()
	print("Tomou dano ", vida_atual)
	if (vida_atual <= 0):
		vida_atual = 0

func muda_animacao():
	pass
	
	
func andar():
#	print("andando")
	$Animation.play("walk")
	pass
	
func correr():
#	print ("correndo")
	$Animation.play("run")
	pass

func parar():
#	print ("parando")
	$Animation.play("idle")
	pass
	
func planar():
#	print ("planando")
	$Animation.play("fly")
	pass
	
func voar():
#	print ("voando")
	$Animation.play("fly")
	pass

func pular():
#	print ("pulando")
	$Animation.play("jump")
	pass

func _on_AreaDano_area_entered(area):
	if (area.has_method("get_tipo")):
		if (area.get_tipo() == "inimigo"):
			self.toma_dano(1)

func _on_Piscar_timeout():
	if (modulate_on == false && delay_dano <= 0):
		$Piscar.stop()
		return
		
	if (modulate_on == false):
		modulate_on = true
		self.modulate = Color(0,0,0,0.5)
	else:
		modulate_on = false
		self.modulate = Color(1,1,1,1)
	
	
	
