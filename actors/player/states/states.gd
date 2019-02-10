extends Node

class_name State

signal finished(next_state_name)

var player_sound_node : AudioStreamPlayer
var player_animation_node : AnimationPlayer

func _ready() -> void:
	player_sound_node = (owner.get_node("PlayerSound") as AudioStreamPlayer)
	player_animation_node = (owner.get_node("AnimationPlayer") as AnimationPlayer)

# Initialize the state. E.g. change the animation
func enter() -> void:
	return

# Clean up the state. Reinitialize values like a timer
func exit() -> void:
	return

func handle_input(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	return

func _on_animation_finished(anim_name: String) -> void:
	return

