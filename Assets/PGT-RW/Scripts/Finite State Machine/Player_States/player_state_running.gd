extends StateBase

# Estado Corriendo
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
func en_fisi_proces(delta):
	CharSS.AnimPlayb.travel(CharSS.anims.Running)
	CharSS.Spr_Running.visible = true
	CharSS.Spr_Idle.visible = false
	CharSS.Spr_Jumping.visible = false
	CharSS.Spr_PreFall.visible = false
	CharSS.Spr_Falling.visible = false
	CharSS.velocity.x = CharSS.run_speed * Input.get_axis("ui_left", "ui_right")
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.Falling)
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
func en_input(_event):
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		CharSS.velocity.x = 0
		state_machine.change_to(CharSS.states.Idle)
			
	if Input.is_action_just_pressed("key_s"):
		state_machine.change_to(CharSS.states.Jumping)
