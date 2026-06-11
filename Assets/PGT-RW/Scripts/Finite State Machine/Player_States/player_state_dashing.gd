extends StateBase

var CharSS:PlayerSS

func start():
	CharSS = nodo_actual

# Estado Dasheando
func en_fisi_proces(_delta: float):
	CharSS.velocity.x = (CharSS.dashing_speed * CharSS.intDash)
	CharSS.velocity.y = 0
		
	if CharSS.velocity.x == 0:
		state_machine.change_to(CharSS.states.Falling)
		
func _on_dashing_timer_timeout() -> void:
	CharSS.velocity.x = move_toward(CharSS.velocity.x, 0, CharSS.friction)
		
