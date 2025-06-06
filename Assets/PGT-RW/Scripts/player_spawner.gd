extends Node2D

var can_spawn:bool = true
var Player1K:Node2D = preload("res://Scenes/player.tscn").instantiate()

func _process(_delta: float) -> void:
	if can_spawn:
		Player1K.global_position = position
		get_parent().add_child.call_deferred(Player1K)
		can_spawn = false
			
