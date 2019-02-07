extends KinematicBody2D

class_name Character

signal direction_changed(new_direction)
signal died()

onready var stats : Stats = ($Stats as Stats)

var look_direction : Vector2 = Vector2(1, 0) setget set_look_direction
var spritedir : String = "horizontal"

func take_damage_from(damage_source: DamageSource) ->void:
	stats.take_damage(damage_source.damage)

func set_dead(value: bool) ->void:
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value
	emit_signal('died')

func set_look_direction(value : Vector2) -> void:
	look_direction = value
	set_look_direction_string()
	emit_signal("direction_changed", value)
	
func set_look_direction_string() -> void:
		match look_direction:
			Vector2(-1,0):
				spritedir = "horizontal"
			Vector2(1,0):
				spritedir = "horizontal"
			Vector2(0,-1):
				spritedir = "up"
			Vector2(1,-1):
				spritedir = "up"
			Vector2(-1,-1):
				spritedir = "up"
			Vector2(0,1):
				spritedir = "down"
			Vector2(1,1):
				spritedir = "down"
			Vector2(-1,1):
				spritedir = "down"
