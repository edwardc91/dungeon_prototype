extends Character

class_name PlayerController

onready var weapon : Area2D = ($WeaponPivot/WeaponOffset/Sword as Area2D)

export(bool) var active_camara_limits = false

func _ready() -> void:
	if active_camara_limits:
		update_camara_limits()

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

