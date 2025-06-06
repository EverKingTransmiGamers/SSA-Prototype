extends StateBase

# Estado Saltando
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
func en_fisi_proces(delta):
	CharSS.Spr_Running.visible = false
	CharSS.Spr_Idle.visible = false
	CharSS.Spr_Jumping.visible = true
	CharSS.Spr_PreFall.visible = false
	CharSS.AnimPlayb.travel(CharSS.anims.Jumping)
	CharSS.velocity.x = CharSS.run_speed * Input.get_axis("ui_left", "ui_right")
	if CharSS.is_on_floor() and CharSS.velocity.y >= 0:
		CharSS.velocity.y = CharSS.jump_height
			
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.Falling)
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
func en_input(event: InputEvent):
	if event.is_action_pressed("ui_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	elif event.is_action_pressed("ui_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
	elif event.is_action_pressed("key_d"):
		CharSS.Dashing_Timer.start()
		state_machine.change_to(CharSS.states.Dashing)
			
			
