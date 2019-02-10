extends "res://actors/characters/Character.gd"

export (int) var speed = 70

var move_dir = Vector2(0,0)
var spritedir = "down"

func _physics_process(delta):
	control_loop()
	movement_loop()
	spritedir_loop()
	
	if move_dir != Vector2(0,0):
		animation_loop("walk")
	else:
		animation_loop("idle")

func control_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	move_dir.x = -int(LEFT) + int(RIGHT)
	move_dir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = move_dir.normalized() * speed
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match move_dir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"
			
func animation_loop(animation):
	var animation_name = str(animation, spritedir)
	if $AnimationPlayer.current_animation != animation_name:
		$AnimationPlayer.play(animation_name) 
	
