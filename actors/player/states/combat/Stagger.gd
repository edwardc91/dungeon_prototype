extends State

class_name Stagger

func enter():
	owner.get_node("AnimationPlayer").play("stagger")
	
func exit():
	owner.get_node("AnimationPlayer").play("SETUP")

func _on_animation_finished(anim_name):
	owner.get_body().modulate = Color("#ffffff")
	emit_signal("finished", "previous")

