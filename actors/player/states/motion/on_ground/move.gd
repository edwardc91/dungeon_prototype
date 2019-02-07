extends OnGround

class_name Move

export(float) var MAX_WALK_SPEED = 100
export(float) var MAX_RUN_SPEED = 150
export(AudioStreamOGGVorbis) var MOVE_SOUND

func enter() -> void:
	speed = 0.0
	velocity = Vector2()

	input_direction = get_input_direction()
	update_look_direction(input_direction)
	player_animation_node.play("walk_" + owner.spritedir)
	player_sound_node.stream = MOVE_SOUND
	player_sound_node.play()
	
func exit() -> void:
	player_sound_node.stop()
	
func handle_input(event: InputEvent):
	return .handle_input(event)
	
func update(delta: float):
	input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
		return
		
	update_look_direction(input_direction)

	speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
	var collision_info : KinematicCollision2D = move(speed, input_direction)
	if not collision_info:
		return
	if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
		return null

