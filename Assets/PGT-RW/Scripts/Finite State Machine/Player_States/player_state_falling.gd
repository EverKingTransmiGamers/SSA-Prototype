extends StateBase

# Estado Cayendo
var CharSS:PlayerSS

# Esta funcion solo se ejecutara una vez que el nodo haya entrado en escena
func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
	
	# Este metodo cambia la animacion
	CharSS.AnimPlayb.travel(CharSS.anims.CayendoQuieto)
		
func en_input(_event: InputEvent):
	
	# Si no se presiona ninguna de las dos teclas, entonces el personaje no correra
	#if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			
	# Si se presiona una de las dos, el personaje correra a su respectiva direccion
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		CharSS.velocity.x = CharSS.runSpeedValue
		if CharSS.is_on_floor():
			CharSS.velocity.y = 0
			state_machine.change_to(CharSS.states.Running)
			
	# Activara el dashing
	if Input.is_action_pressed("dash"):
		print("De momento no funcaa")
		#CharSS.Dashing_Timer.start()
		#state_machine.change_to(CharSS.states.Dashing)
			
	# Estos haran que el dashing apunte a su respectiva direccion, y volteara al jugador.
	if Input.is_action_just_pressed("move_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if Input.is_action_just_pressed("move_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
func en_fisi_proces(delta: float) -> void:
		
	gravity1k(delta)
	print("Cayendo. ",CharSS.is_on_floor(), ", Velocidad actual en caída es: ", CharSS.velocity.y)
	CharSS.velocity.x = CharSS.runSpeedValue
	
	if CharSS.is_on_floor() and CharSS.velocity.x != 0:
		CharSS.velocity.y = 0
		state_machine.change_to(CharSS.states.Running)
	
	elif CharSS.is_on_floor() and CharSS.velocity.x == 0:
		CharSS.velocity.y = 0
		state_machine.change_to(CharSS.states.Idle)
			
# Esta funcion hara que el jugador caiga
func gravity1k(delta):
	#CharSS.velocity.y = (CharSS.gravity * CharSS.masa) * delta
	CharSS.velocity.y = move_toward(
		CharSS.velocity.y,
		(CharSS.gravity * CharSS.masa),
		((CharSS.gravity * CharSS.masa) * 2 * delta)
		)
			
