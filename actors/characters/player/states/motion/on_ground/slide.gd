extends OnGround

class_name Slide

export(float) var MAX_SLIDE_SPEED = 250
export(float) var SLIDE_LENGHT = 70
export(AudioStreamOGGVorbis) var SLIDE_SOUND

func enter() -> void:
	speed = 0.0
	velocity = Vector2()
	
	input_direction = get_input_direction()
	update_look_direction(input_direction)
	target = (SLIDE_LENGHT * input_direction) + owner.position
	player_animation_node.play("slide_" + owner.spritedir)
	player_sound_node.stream = SLIDE_SOUND
	player_sound_node.play()
	print("Position owner on slide " + (owner.position as String))
	
func handle_input(event: InputEvent):
	return .handle_input(event)
	
func update(delta: float):
	direction = (target - owner.position)
	if direction.length() > 5:
		var collision_info : KinematicCollision2D = move(MAX_SLIDE_SPEED, target - owner.position)
		if  collision_info:
			emit_signal("finished", "idle")
	else:
		emit_signal("finished", "idle")

