extends StateBase

# Estado Quieto
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
	CharSS.AnimPlayb.travel(CharSS.anims.Quieto)
		
func en_input(_event: InputEvent):
			
	if Input.is_action_just_pressed("move_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if Input.is_action_just_pressed("move_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(CharSS.states.Jumping)
			
func en_fisi_proces(delta: float):
	#print("Cayo. ",CharSS.is_on_floor(),", ",CharSS.velocity.y)
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_to(CharSS.states.Accelerating)
			
	elif CharSS.velocity.y > 0 and not CharSS.is_on_floor():
		state_machine.change_to(CharSS.states.Falling)
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
