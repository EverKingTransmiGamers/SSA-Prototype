extends StateBase

# Estado Corriendo
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
	
	CharSS.SS_GeneralActions.visible = false
	CharSS.SS_MovementActions.visible = true
	
	CharSS.AnimPlayb.travel(CharSS.anims.Corriendo)
		
func en_input(_event):
	#region Volteara tanto al personaje como al valor del dashing
	if Input.is_action_just_pressed("move_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if Input.is_action_just_pressed("move_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			#endregion
			
	# Esto nos permitira saltar
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(CharSS.states.JumpinRunnin)
			
func en_fisi_proces(delta):
	# Esto hara que el jugador pueda correr
	CharSS.velocity.x = CharSS.velocity.x
	
	# Esto hara que el jugador frene y luego cambie de estado
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		state_machine.change_to(CharSS.states.StoppinRunnin)
		#CharSS.velocity.x = move_toward(CharSS.velocity.x, 0, (CharSS.friction * delta * -1))
		#print(CharSS.velocity.x)
		#CharSS.AnimPlayb.travel(CharSS.anims.Quieto)
		#if CharSS.velocity.x == 0:
			#state_machine.change_to(CharSS.states.Idle)
			
	
	# Esto hara que el jugador caiga
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.FallinRunnin)
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
