extends OnGround

class_name Idle

func enter() -> void:
	player_animation_node.play("idle_" + owner.spritedir)
	
func handle_input(event: InputEvent):
	return .handle_input(event)

func update(delta: float) -> void:
	var input_direction : Vector2 = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")