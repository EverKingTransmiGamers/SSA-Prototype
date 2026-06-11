extends StateBase

# Estado Saltando Quieto
var CharSS:PlayerSS

var airSpeedValue:float

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
	CharSS.AnimPlayb.travel(CharSS.anims.SaltandoQuieto)
		
func en_fisi_proces(delta:float) -> void:
	airSpeedValue = CharSS.airSpeed * Input.get_axis("move_left", "move_right")
	CharSS.velocity.x = move_toward(CharSS.velocity.x, airSpeedValue, (CharSS.airFriction * delta))
	print(CharSS.velocity.x)
	if CharSS.is_on_floor() and CharSS.velocity.y >= 0:
		CharSS.velocity.y = CharSS.jump_height
			
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.Falling)
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
func en_input(event:InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	if event.is_action_pressed("move_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
	elif event.is_action_pressed("dash"):
		CharSS.Dashing_Timer.start()
		state_machine.change_to(CharSS.states.Dashing)
			
			
