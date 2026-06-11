extends StateBase

# Estado Plantilla
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual
		
	CharSS.SS_GeneralActions.visible = true
	CharSS.SS_MovementActions.visible = false
		
func en_input(_event:InputEvent):
	pass
			
func en_fisi_proces(delta:float):
	pass
	gravity1k(delta)
		
func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
