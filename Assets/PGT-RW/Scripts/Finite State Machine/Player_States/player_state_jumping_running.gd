extends StateBase

# Estado Saltando Corriendo
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = false
	CharSS.SS_MovementActions.visible = true
	CharSS.AnimPlayb.travel(CharSS.anims.SaltandoCorri)
		
func en_input(_event:InputEvent):
	pass
			
func en_fisi_proces(delta:float):
	CharSS.velocity.x = CharSS.runSpeedValue
	
	#if CharSS.is_on_floor() and CharSS.velocity.y == 0:
	CharSS.velocity.y = CharSS.jump_height
			
	if CharSS.velocity.y > 0:
		state_machine.change_to(CharSS.states.FallinRunnin)
			
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
