extends KinematicBody2D

class_name Monster

signal died

var state
var active : bool

export(float) var ARRIVE_DISTANCE = 6.0
export(float) var DEFAULT_SLOW_RADIUS = 100.0
export(float) var DEFAULT_MAX_SPEED = 100.0
export(float) var MASS = 8.0

onready var stats : Stats = ($Stats as Stats)
onready var body_pivot : Position2D = ($BodyPivot as Position2D)
onready var collision_shape : CollisionShape2D = ($CollisionShape2D as CollisionShape2D)
onready var hit_box : Area2D = ($HitBox as Area2D)

var target : Character = null # Actor

var start_position : Vector2 = Vector2()
var velocity : Vector2 = Vector2()
var look_direction : Vector2 = Vector2(1, 0) setget set_look_direction



func _ready() ->void:
	# set_as_toplevel(true)
	start_position = global_position
	initialize()

func initialize() ->void:
	# if not target_actor is Character:
	#	return
	# target = target_actor
	# target.connect('died', self, '_on_target_died')
	target = (get_parent().get_node("Player") as Character)
	set_active(true)

func _on_target_died() ->void:
	target = null

func take_damage_from(damage_source: DamageSource) ->void:
	stats.take_damage(damage_source.damage)

func set_active(value: bool) ->void:
	active = value
	set_physics_process(value)
	($HitBox as HitBox).set_active(value)
	# ($DamageSource as DamageSource).set_active(value)
	
func set_look_direction(value : Vector2) -> void:
	look_direction = value
	
func update_look_direction(direction: Vector2) -> void:
	var change_collision : bool = false
	if direction and look_direction != direction:
		if look_direction.x != direction.x:
			change_collision = true
		set_look_direction(direction)
	
	if not direction.x in [-1, 1]:
		return
		
	body_pivot.set_scale(Vector2(direction.x, 1))
	if change_collision:
		collision_shape.position.x = collision_shape.position.x * -1
		hit_box.position.x = hit_box.position.x * -1
	
func calculate_look_direction(current_position: Vector2, target_position: Vector2) ->Vector2:
	var look_direction : Vector2 = Vector2()
	
	if current_position.x < target_position.x:
		look_direction.x = 1
	elif current_position.x > target_position.x:
		look_direction.x = -1
	if current_position.y < target_position.y:
		look_direction.y = 1
	elif current_position.y > target_position.y:
		look_direction.y = -1
		
	return look_direction

