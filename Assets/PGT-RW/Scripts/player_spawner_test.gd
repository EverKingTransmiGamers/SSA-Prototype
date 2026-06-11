extends Node2D

var Player1K:Node2D = load("res://Scenes/Player.tscn").instantiate()

func _ready() -> void:
	Player1K.global_position = position
	get_parent().add_child.call_deferred(Player1K)
		
