class_name PlayerSS extends CharacterBody2D

signal toWarp

# Son un importador de clases y grupos de namespaces como en C++
var states:PlayerStateNames = PlayerStateNames.new()
var anims:PlayerAnimNames = PlayerAnimNames.new()

#region essential nodes
@onready var SS_Anims:Node2D = $Sprite_Animations
@onready var PlayerAnims:AnimationTree = $AnimationTree
@onready var Dashing_Timer:Timer = $DashingTimer
@onready var CoyoteTimer:Timer = $CoyoteTimer
@onready var AnimPlayb:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var damageDetector:Area2D = %Damage_Detector
@onready var interactDetector:Area2D = %Interact_Detector
#endregion

#region sprite nodes
@onready var SS_GeneralActions:Sprite2D = $Sprite_Animations/SS_GeneralActions
@onready var SS_MovementActions:Sprite2D = $Sprite_Animations/SS_MovementActions
#endregion

#region main variants
@export_category("Main Settings")
@export var run_speed:int = 900
@export var dashing_speed:int = 1300
@export var jump_height:int = -1090
@export var gravity:float = 98.1
@export var masa:int = 24
	
@export_category("Speed Settings")
@export var aceleration:float = 1400
@export var friction:float = 825
@export var frictAccel:float = 900
@export var airSpeed:float = 650
@export var airFriction:float
	
var runSpeedValue:float
var intDash:int = 1
#endregion

func _physics_process(_delta: float) -> void:
	runSpeedValue = (run_speed * Input.get_axis("move_left", "move_right"))
	# Esto garantiza que las fisicas de mi personaje funcionen correctamente
	move_and_slide()
	
	_warping()
		
func _warping() -> void:
	if %Warp_Cont.visible and Input.is_action_just_pressed("ui_up"):
		print("Viajando a otro nivel")
		toWarp.emit()
			
# Esto detectará si el jugador recibio daño y lo matará al instante.
func _on_damage_area_entered(enemy:Area2D) -> void:
	if enemy.is_in_group("Enemy") and enemy.get_collision_layer_value(2):
		get_tree().change_scene_to_file.call_deferred("res://Scenes/death_screen.tscn")
			
#region Interactive Object detector
# Estas funciones detectarán si el cuerpo puede o no interactuar con los objetos
func _interact_detector_entered(area:Area2D) -> void:
	if area.is_in_group("Level_Warp") and area.get_collision_layer_value(5):
		%Warp_Cont.visible = true
			
func _interact_detector_exited(_area:Area2D) -> void:
	$Warp_Cont.visible = false
			
#endregion
