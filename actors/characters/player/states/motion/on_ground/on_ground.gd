extends Motion

class_name OnGround

var speed : float = 0.0
var velocity : Vector2 = Vector2()

var input_direction : Vector2
var target : Vector2
var direction: Vector2

func handle_input(event: InputEvent):
	return .handle_input(event)
	
func move(speed: float, direction: Vector2) -> KinematicCollision2D:
	velocity = direction.normalized() * speed
	var player_root_node : KinematicBody2D = (owner as KinematicBody2D)
	player_root_node.move_and_slide(velocity, Vector2(), 5, 2)
	if player_root_node.get_slide_count() == 0:
		return null
	return player_root_node.get_slide_collision(0)

