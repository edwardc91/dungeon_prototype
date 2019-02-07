extends Monster

class_name Minotaur

enum STATES {IDLE = 0, ROAM = 1}

export(float) var MAX_ROAM_SPEED = 200.0
export(float) var ROAM_RADIUS = 140.0

var timer : Timer
onready var animation_player : AnimationPlayer = ($AnimationPlayer as AnimationPlayer)
onready var tween : Tween = ($Tween as Tween)

var roam_target_position : Vector2 = Vector2()
var roam_slow_radius : float = 0.0
var steering : Steering 

func initialize() ->void:
	timer = ($Timer as Timer)
	animation_player = ($AnimationPlayer as AnimationPlayer)
	steering = Steering.new()
	.initialize()
	# tween.connect('tween_completed', self, '_on_tween_completed')
	# animation_player.connect('animation_finished', self, '_on_animation_finished')
	timer.connect('timeout', self, '_on_Timer_timeout')
	_change_state(STATES.IDLE)
	
func _change_state(new_state: int) ->void:
	if not active:
		return
	match state:
		STATES.IDLE:
			timer.stop()
	match new_state:
		STATES.IDLE:
			randomize()
			timer.wait_time = randf() * 2 + 1.0
			timer.start()
			animation_player.play("idle")
		STATES.ROAM:
			randomize()
			var random_angle = randf() * 2 * PI
			randomize()
			var random_radius = (randf() * ROAM_RADIUS) / 2 + ROAM_RADIUS / 2
			roam_target_position = start_position + Vector2(cos(random_angle) * random_radius, sin(random_angle) * random_radius)
			roam_slow_radius = roam_target_position.distance_to(start_position) / 2
			var new_look_direction : Vector2 = calculate_look_direction(position, roam_target_position)
			update_look_direction(new_look_direction)
			animation_player.play("walk")
	state = new_state
	
func _physics_process(delta: float) ->void:
	var current_state : int = state
	match current_state:
		STATES.IDLE:
			if not target:
				return
			# if position.distance_to(target.position) < SPOT_RANGE:
			#	_change_state(SPOT)
		STATES.ROAM:
			velocity = steering.arrive_to(velocity, position, roam_target_position, MASS, roam_slow_radius, MAX_ROAM_SPEED)
			move_and_slide(velocity)
			if get_slide_count() != 0:
				var collision_info : KinematicCollision2D = get_slide_collision(0)
				if  collision_info:
					_change_state(STATES.IDLE)
			if position.distance_to(roam_target_position) < ARRIVE_DISTANCE:
				_change_state(STATES.IDLE)
			if not target:
				return
			# elif position.distance_to(target.position) < SPOT_RANGE:
			#	_change_state(SPOT)
			
func _on_Timer_timeout():
	match state:
		STATES.IDLE:
			_change_state(STATES.ROAM)




