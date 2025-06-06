class_name PlayerSS
extends CharacterBody2D

#region essential nodes
var states:PlayerStateNames = PlayerStateNames.new()
var anims:PlayerAnimNames = PlayerAnimNames.new()
@onready var SS_Anims:Node2D = $Sprite_Animations
@onready var PlayerAnims:AnimationTree = $AnimationTree
@onready var Dashing_Timer:Timer = $Dashing_timer
@onready var AnimPlayb:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
#endregion
#region sprite nodes
@onready var Spr_Idle:Sprite2D = $Sprite_Animations/SS_Anim_Idle
@onready var Spr_Running:Sprite2D = $Sprite_Animations/SS_Anim_Running
@onready var Spr_Jumping:Sprite2D = $Sprite_Animations/SS_Anim_Jumping
@onready var Spr_PreFall:Sprite2D = $"Sprite_Animations/SS_Anim_Pre-Fall"
@onready var Spr_Falling:Sprite2D = $Sprite_Animations/SS_Anim_Falling
#endregion
#region main variants
var intDash:int = 1
@export_category("Main Settings")
@export var run_speed: int = 900
@export var dashing_speed: int = 1600
@export var jump_height: int = -960
@export var gravity: float = 98.1
@export var masa: int = 24
#endregion

func _physics_process(_delta: float) -> void:
	move_and_slide()
		
func _on_death_col_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_tree().change_scene_to_file.call_deferred("res://Scenes/death_screen.tscn")
			
