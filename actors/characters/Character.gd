extends KinematicBody2D

class_name Character

signal direction_changed(new_direction)

var look_direction : Vector2 = Vector2(1, 0) setget set_look_direction
var spritedir : String = "horizontal"

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
