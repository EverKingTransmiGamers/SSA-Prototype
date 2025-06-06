extends StateBase

# Estado Cayendo
var CharSS:PlayerSS

func start():
	CharSS = nodo_actual

func en_fisi_proces(delta: float):
	CharSS.Spr_Running.visible = false
	CharSS.Spr_Idle.visible = false
	CharSS.Spr_Jumping.visible = false
	CharSS.Spr_PreFall.visible = true
	CharSS.AnimPlayb.travel(CharSS.anims.PreFall)
	#print("Cayendo. ",CharSS.is_on_floor(), ", ", CharSS.velocity.y)
	if CharSS.velocity.y >= 0 and CharSS.is_on_floor():
		state_machine.change_to(CharSS.states.Idle)
			
	gravity1k(delta)

func gravity1k(delta):
	CharSS.velocity.y += (CharSS.gravity * CharSS.masa) * delta
		
func en_input(_event: InputEvent):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		CharSS.velocity.x = CharSS.run_speed * Input.get_axis("ui_left", "ui_right")
			
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		CharSS.velocity.x = 0
			
	elif Input.is_action_pressed("key_d"):
		CharSS.Dashing_Timer.start()
		state_machine.change_to(CharSS.states.Dashing)
			
	elif Input.is_action_just_pressed("ui_left"):
		CharSS.SS_Anims.scale.x = -1
		CharSS.intDash = -1
			
	elif Input.is_action_just_pressed("ui_right"):
		CharSS.SS_Anims.scale.x = 1
		CharSS.intDash = 1
			
func _on_animation_tree_animation_player_changed() -> void:
	if CharSS.anims.Falling:
		CharSS.Spr_PreFall.visible = false
		CharSS.Spr_Falling.visible = true
