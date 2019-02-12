extends Node2D

class_name Weapon

signal combo_finished()
signal single_attack_started(dash_lenght)

enum STATES { IDLE = 0, ATTACK = 1}
var state : int

enum ATTACK_INPUT_STATES { WAITING = 0, LISTENING = 1, REGISTERED = 2}
var attack_input_state: int = ATTACK_INPUT_STATES.WAITING
var ready_for_next_attack : bool = false

var attack_id : int = 0
var current_dash_length : float = 0.0
var current_damage : float = 0.0
var combo : Array = []
	
var animation_player : AnimationPlayer
var weapon_damage_source
var dm_instance
	
func _ready():
	animation_player = ($AnimationPlayer as AnimationPlayer)
	animation_player.connect('animation_started', self, "on_animation_started")
	animation_player.connect('animation_finished', self, "_on_animation_finished")
	_change_state(STATES.IDLE)
	
func _change_state(new_state: int) ->void:
	match state:
		STATES.IDLE:
			visible = true
	match new_state:
		STATES.IDLE:
			attack_id = 0
			visible = false
		STATES.ATTACK:
			attack_input_state = ATTACK_INPUT_STATES.WAITING
			ready_for_next_attack = false
			var attack : Dictionary = combo[min(attack_id, combo.size() - 1)]
			current_dash_length = attack['dash_lenght']
			current_damage = attack['damage']
			animation_player.play(attack['animation'])
			attack_id += 1
	state = new_state
	
func _input(event: InputEvent) ->void:
	if not state == STATES.ATTACK:
		return
	if attack_input_state != ATTACK_INPUT_STATES.LISTENING:
		return
	if event.is_action_pressed('attack'):
		attack_input_state = ATTACK_INPUT_STATES.REGISTERED

func _physics_process(delta: float) ->void:
	if attack_input_state == ATTACK_INPUT_STATES.REGISTERED and ready_for_next_attack:
		attack()

func attack() ->void:
	_change_state(STATES.ATTACK)

# use with AnimationPlayer func track
func set_attack_input_listening() ->void:
	attack_input_state = ATTACK_INPUT_STATES.LISTENING

# use with AnimationPlayer func track
func set_ready_for_next_attack() ->void:
	ready_for_next_attack = true

func _on_animation_finished(name: String) ->void:
	if not name == "SETUP":
		if attack_input_state == ATTACK_INPUT_STATES.REGISTERED and attack_id < combo.size():
			set_ready_for_next_attack()
		else:
			_change_state(STATES.IDLE)
			emit_signal("combo_finished")
		
func on_animation_started(name: String) ->void:
	emit_signal("single_attack_started", current_dash_length)
	
func set_to_idle_state():
	#animation_player.play("SETUP")
	owner.get_body().modulate = Color("#ffffff")
	visible = false
	_change_state(STATES.IDLE)