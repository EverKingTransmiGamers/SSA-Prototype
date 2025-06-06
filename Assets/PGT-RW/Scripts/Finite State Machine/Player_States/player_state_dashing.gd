extends StateBase

var CharSS:PlayerSS

func start():
	CharSS = nodo_actual

# Estado Dasheando
func en_fisi_proces(_delta: float):
	CharSS.velocity.x = (CharSS.dashing_speed * CharSS.intDash)
	CharSS.velocity.y = 0
		
func _on_dashing_timer_timeout() -> void:
	CharSS.Dashing_Timer.stop()
	state_machine.change_to(CharSS.states.Falling)
		
