class_name TestLevelClass extends Node2D

enum TestLvlState{
	SelectorRoom,
	LevelRoom
}

@export var currentLvlState:TestLvlState
@export var levelSceneNameID:String

var playerSpawnPosRef:Marker2D
var levelwarp_tmlayer:TileMapLayer
var level_travelers:Array

func _process(_delta: float) -> void:
	match currentLvlState:
		TestLvlState.SelectorRoom:
			if self.has_node("LevelWarp_TMLayer"):
				levelwarp_tmlayer = get_node("LevelWarp_TMLayer")
			else:
				levelwarp_tmlayer = null
					
		TestLvlState.LevelRoom:
			if self.has_node("PlayerSpawnerPosRef"):
				playerSpawnPosRef = get_node("PlayerSpawnerPosRef")
			else:
				playerSpawnPosRef = null
