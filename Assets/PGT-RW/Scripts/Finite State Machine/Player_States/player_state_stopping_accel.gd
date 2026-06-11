extends StateBase

# Estado Parando de Acelerar
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
		
	CharSS.AnimPlayb.travel(CharSS.anims.FrenandoAcel)
		
func en_input(_event:InputEvent):
	pass
			
func en_fisi_proces(delta:float):
	CharSS.velocity.x = move_toward(CharSS.velocity.x, 0, (CharSS.frictAccel * delta))
		
	if CharSS.velocity.x > 799 or CharSS.velocity.x < -799:
		CharSS.SS_GeneralActions.visible = false
		CharSS.SS_MovementActions.visible = true
			
	if CharSS.velocity.x == 0:
		state_machine.change_to(CharSS.states.Idle)
			
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
