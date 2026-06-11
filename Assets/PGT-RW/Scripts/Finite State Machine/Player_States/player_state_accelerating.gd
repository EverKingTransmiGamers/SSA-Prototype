extends StateBase

# Estado Acelerando
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
	
	CharSS.AnimPlayb.travel(CharSS.anims.Corriendo)
		
func en_input(_event:InputEvent):
	# Esto nos permitira saltar
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(CharSS.states.JumpinRunnin)
			
func en_fisi_proces(delta:float):
	if CharSS.velocity.x >= 900 or CharSS.velocity.x <= -900:
		state_machine.change_to(CharSS.states.Running)
			
	CharSS.velocity.x = move_toward(CharSS.velocity.x, CharSS.runSpeedValue, (CharSS.aceleration * delta))	
		
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		state_machine.change_to(CharSS.states.StoppingAccel)
		if CharSS.velocity.x >= 490:
			state_machine.change_to(CharSS.states.StoppingAccel)
				
		if CharSS.velocity.x <= -490:
			state_machine.change_to(CharSS.states.StoppingAccel)
				
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
