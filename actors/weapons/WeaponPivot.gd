extends Position2D

func _ready() ->void:
	owner.connect("direction_changed", self, "_on_Player_direction_changed")

func _on_Player_direction_changed(new_direction: Vector2) ->void:
	rotation = new_direction.angle()
	show_behind_parent = new_direction == Vector2(0, -1)
	print("Weapon direction angle " + (rotation as String))
	print("direction sended " + (new_direction as String))

