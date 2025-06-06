extends StateBase

# Estado Quieto
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
func en_fisi_proces(delta: float):
	CharSS.velocity.x = 0
	CharSS.Spr_Falling.visible = false
	CharSS.Spr_Running.visible = false
	CharSS.Spr_Idle.visible = true
	CharSS.Spr_Jumping.visible = false
	CharSS.Spr_PreFall.visible = false
	CharSS.AnimPlayb.travel(CharSS.anims.Idle)
	#print("Cayo. ",CharSS.is_on_floor(),", ",CharSS.velocity.y)
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_to(CharSS.states.Running)
			
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.Falling)
	gravity1k(delta)
		
func en_input(_event: InputEvent):
			
	if Input.is_action_just_pressed("ui_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if Input.is_action_just_pressed("ui_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
	if Input.is_action_just_pressed("key_s"):
		state_machine.change_to(CharSS.states.Jumping)
			
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
