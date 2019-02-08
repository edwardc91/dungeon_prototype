extends Monster

class_name Minotaur

enum STATES {IDLE = 0, 
			ROAM = 1, 
			SPOT = 2, 
			FOLLOW = 3, 
			RETURN = 4, 
			PREPARE_TO_ATTACK = 5, 
			ATTACK = 6,
			STAGGER = 7}

export(float) var MAX_ROAM_SPEED = 50.0
export(float) var ROAM_RADIUS = 60.0

export(float) var SPOT_RANGE = 100.0
export(float) var FOLLOW_RANGE = 200.0

export(float) var MAX_FOLLOW_SPEED = 60.0

export(float) var ATTACK_RANGE = 15.0
export(float) var PREPARE_TO_ATTACK_WAIT_TIME = 0.9

var timer : Timer
onready var animation_player : AnimationPlayer = ($AnimationPlayer as AnimationPlayer)
onready var tween : Tween = ($Tween as Tween)

var roam_target_position : Vector2 = Vector2()
var roam_slow_radius : float = 0.0
var steering : Steering 
var current_attack : int = 0

func initialize() ->void:
	timer = ($Timer as Timer)
	animation_player = ($AnimationPlayer as AnimationPlayer)
	steering = Steering.new()
	.initialize()
	# tween.connect('tween_completed', self, '_on_tween_completed')
	animation_player.connect('animation_finished', self, '_on_animation_finished')
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
		STATES.STAGGER:
			animation_player.play("stagger")
		STATES.SPOT:
			var new_look_direction : Vector2 = calculate_look_direction(position, target.position)
			update_look_direction(new_look_direction)
			animation_player.play('spot')
		STATES.FOLLOW:
			animation_player.play("walk")
		STATES.RETURN:
			var new_look_direction : Vector2 = calculate_look_direction(position, start_position)
			update_look_direction(new_look_direction)
			animation_player.play("walk")
		STATES.PREPARE_TO_ATTACK:
			timer.wait_time = PREPARE_TO_ATTACK_WAIT_TIME
			randomize()
			current_attack = (rand_range(0,2) as int)
			if current_attack == 0:
				animation_player.play("prepare_slash_attack")
			else:
				animation_player.play("prepare_spin_attack")
			timer.start()
		STATES.ATTACK:
			if current_attack == 0:
				animation_player.play("slash_attack")
			else:
				animation_player.play("spin_attack")
	state = new_state
	
func _physics_process(delta: float) ->void:
	var current_state : int = state
	match current_state:
		STATES.IDLE:
			if not target:
				return
			if position.distance_to(target.position) < SPOT_RANGE:
				_change_state(STATES.SPOT)
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
			elif position.distance_to(target.position) < SPOT_RANGE:
				_change_state(STATES.SPOT)
		STATES.RETURN:
			velocity = steering.arrive_to(velocity, position, start_position, MASS, roam_slow_radius, MAX_ROAM_SPEED)
			move_and_slide(velocity)
			if position.distance_to(start_position) < ARRIVE_DISTANCE:
				_change_state(STATES.IDLE)
			elif not target:
				return
			elif position.distance_to(target.position) < SPOT_RANGE:
				_change_state(STATES.SPOT)
		STATES.FOLLOW:
			if not target:
				_change_state(STATES.RETURN)
				return
			var new_look_direction : Vector2 = calculate_look_direction(position, target.position)
			update_look_direction(new_look_direction)
			velocity = steering.follow(velocity, position, target.position, MAX_FOLLOW_SPEED)
			move_and_slide(velocity)

			if position.distance_to(target.position) < ATTACK_RANGE:
				_change_state(STATES.PREPARE_TO_ATTACK)

			if position.distance_to(target.position) > FOLLOW_RANGE:
				_change_state(STATES.RETURN)
			
func _on_Timer_timeout():
	match state:
		STATES.IDLE:
			_change_state(STATES.ROAM)
		STATES.PREPARE_TO_ATTACK:
			animation_player.play("SETUP")
			_change_state(STATES.ATTACK)
			
func _on_animation_finished(anim_name):
	match anim_name:
		'spot':
			_change_state(STATES.FOLLOW)
		'stagger':
			_change_state(STATES.IDLE)
		'slash_attack': 
			_change_state(STATES.FOLLOW)
		'spin_attack':
			_change_state(STATES.FOLLOW)



