extends Character

class_name PlayerController

onready var weapon : Area2D = ($WeaponPivot/WeaponOffset/Sword as Area2D)
onready var body : Sprite = ($BodyPivot/Body as Sprite)
onready var state_machine : StateMachine = ($StateMachine as StateMachine)

export(bool) var active_camara_limits = false

func _ready() -> void:
	if active_camara_limits:
		update_camara_limits()
		
		
func get_body() -> Sprite:
	return body
	
func get_stats_node():
	return stats
	
func take_damage_from(damage_source: DamageSource) ->void:
	if state_machine.current_state == $StateMachine/Stagger:
		return
	 ($StateMachine/Stagger as Stagger).knockback_direction = (damage_source.global_position - global_position).normalized()
	.take_damage_from(damage_source)

func update_camara_limits() -> void:
	var root_node : Node = (get_parent().get_parent() as Node)
	var floor_tilset : TileMap = (root_node.get_node("Floor") as TileMap)
	var map_limits : Rect2 = floor_tilset.get_used_rect()
	var map_cellsize : Vector2 = floor_tilset.cell_size
	
	var camara_node : Camera2D = ($CamaraPivot/CamaraOffset/Camera2D as Camera2D)
	camara_node.limit_left = map_limits.position.x * map_cellsize.x
	camara_node.limit_right = map_limits.end.x * map_cellsize.x
	camara_node.limit_top = map_limits.position.y * map_cellsize.y
	camara_node.limit_bottom = map_limits.end.y * map_cellsize.y

