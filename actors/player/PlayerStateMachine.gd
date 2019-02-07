extends StateMachine

class_name PlayerStateMachine

func _ready():
	states_map = {
		"idle": ($Idle as Node),
		"move": ($Move as Node),
		"slide": ($Slide as Node),
 #		"jump": $Jump,
 #		"stagger": $Stagger,
 		"attack": $Attack,
	}
	
	for state in get_children():
		state.connect("finished", self, "_change_state")
	connect("state_changed", self, "_debug_state_changed")
		
func _change_state(state_name: String) -> void:
	if state_name in ["move"] and current_state == states_map["slide"]:
		return
		
	# this condition is used when the new state finished must save the previus state in 
	# the stack
	if state_name in ['attack',]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('slide'):
		if current_state in [$Slide, $Idle, $Attack]:
			return
		_change_state('slide')
		get_tree().set_input_as_handled()
		return
	if event.is_action_pressed('attack'):
		if current_state in [$Attack, $Slide]:
			return
		_change_state('attack')
		get_tree().set_input_as_handled()
		return
	current_state.handle_input(event)
	
func _debug_state_changed(current_state: Node) -> void:
	print(current_state.name)

