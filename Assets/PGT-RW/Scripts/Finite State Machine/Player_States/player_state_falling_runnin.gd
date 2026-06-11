extends StateBase

# Estado Cayendo Mientras Corre
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = false
	CharSS.SS_MovementActions.visible = true
		
	CharSS.AnimPlayb.travel(CharSS.anims.CaidaCorri)
	CharSS.CoyoteTimer.start()
		
func en_input(_event:InputEvent):
	# Estas condicionales voltearan al personaje y a su valor del dashing
	if Input.is_action_just_pressed("move_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if Input.is_action_just_pressed("move_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
func en_fisi_proces(delta:float):
	CharSS.velocity.x = CharSS.run_speed * Input.get_axis("move_left", "move_right")
		
	if not CharSS.is_on_floor() and not CharSS.CoyoteTimer.is_stopped():
		if Input.is_action_just_pressed("jump"):
			state_machine.change_to(CharSS.states.JumpinRunnin)
			
	if CharSS.velocity.y == 0 and CharSS.velocity.x == 0 and CharSS.is_on_floor():
		state_machine.change_to(CharSS.states.Idle)
			
	if CharSS.velocity.x > 0 or CharSS.velocity.x < 0:
		if CharSS.velocity.y == 0 and CharSS.is_on_floor():
			state_machine.change_to(CharSS.states.Running)
			
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
