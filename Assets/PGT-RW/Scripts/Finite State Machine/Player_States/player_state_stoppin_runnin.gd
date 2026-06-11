extends StateBase

# Estado Freanndo despues de Correr
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = false
	CharSS.SS_MovementActions.visible = true
	
	CharSS.AnimPlayb.travel(CharSS.anims.Quieto)
		
func en_input(_event:InputEvent):
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to(CharSS.states.JumpinRunnin)
			
func en_fisi_proces(delta:float):
	#CharSS.velocity.x = move_toward(CharSS.velocity.x, 0, (CharSS.friction * delta * -1))
	if CharSS.velocity.x == 0:
		CharSS.AnimPlayb.travel(CharSS.anims.Quieto)
		state_machine.change_to(CharSS.states.Idle)
			
	CharSS.velocity.x = move_toward(CharSS.velocity.x, 0, (CharSS.friction * delta))
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
