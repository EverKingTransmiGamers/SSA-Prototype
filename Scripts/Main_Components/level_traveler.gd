class_name LevelTraveler extends Area2D

@export var levelName:String
@onready var text_area:Control = $Text_Container/Label

func _ready() -> void:
	text_area.text = levelName
		
func _process(_delta: float) -> void:
	pass
		
func printaa(my_txt:String) -> void:
	print(my_txt)
