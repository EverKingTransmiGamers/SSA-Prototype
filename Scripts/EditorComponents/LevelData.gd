class_name LevelData extends Resource

# Información inicial del nivel.
@export var levelName:StringName
@export var levelDescription:String
var creationDate:String
var modifiedDate:String
#var chunksPath:String = "/Chunks/"

func set_creation_date() -> void:
	creationDate = (
		str(Time.get_date_dict_from_system()["year"] ) +
		"/" +
		str(Time.get_date_dict_from_system()["month"] ) +
		"/" +
		str(Time.get_date_dict_from_system()["day"] ) +
		", " +
		str(Time.get_time_dict_from_system()["hour"] ) +
		":" +
		str(Time.get_time_dict_from_system()["minute"] ) +
		":" +
		str(Time.get_time_dict_from_system()["second"] )
	)
