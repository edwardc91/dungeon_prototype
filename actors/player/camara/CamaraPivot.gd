extends Position2D

class_name CamaraPivot

onready var parent : KinematicBody2D = (get_parent() as KinematicBody2D)

func _ready() -> void:
	update_pivot_angle()
	
func _physics_process(delta: float):
	update_pivot_angle()

func update_pivot_angle() -> void:
	rotation = parent.look_direction.angle()
