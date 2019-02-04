extends State

class_name Motion

func handle_input(event: InputEvent):
	pass

func get_input_direction() -> Vector2:
	var input_direction : Vector2 = Vector2()
	input_direction.x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input_direction
	
func update_look_direction(direction: Vector2) -> void:
	if direction and owner.look_direction != direction:
		owner.set_look_direction(direction)
		print(direction)
	
	if not direction.x in [-1, 1]:
		return
		
	owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))

