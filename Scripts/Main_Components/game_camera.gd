class_name GameCamera
extends Camera2D

var Player1K:PlayerSS = self.owner

func _physics_process(_delta: float) -> void:
	if owner == Player1K:
		pass
		#if Player1K.velocity.x > 1:
			#drag_horizontal_offset = move_toward(drag_horizontal_offset, 1.0, 100 * delta)
	else:
		pass
