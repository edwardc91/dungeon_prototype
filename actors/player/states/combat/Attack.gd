extends OnGround

class_name Attack

var current_dash_lenght : float = 0.0

var dash_speed : float = 200

func _ready()->void:
	var weapon : Area2D = (get_node("../../WeaponPivot/WeaponOffset").get_child(0) as Area2D)
	weapon.connect("combo_finished", self, "_on_Sword_combo_finished")
	weapon.connect("single_attack_started", self, "_on_single_attack_started")

func enter() ->void:
	player_animation_node.play("attack_" + owner.spritedir)
	owner.weapon.attack()
	
func update(delta: float) -> void:
	if current_dash_lenght != 0:
		direction = (target - owner.position)
		if direction.length() > 5:
			var collision_info : KinematicCollision2D = move(dash_speed, direction)
			if  collision_info:
				current_dash_lenght = 0
		else:
			current_dash_lenght = 0
					

func _on_Sword_combo_finished() ->void:
	emit_signal("finished", "previous")
	
func _on_single_attack_started(dash_lenght: float) -> void:
	current_dash_lenght = dash_lenght
	target = (current_dash_lenght * owner.look_direction) + owner.position
	print("Attack look dir " + (owner.look_direction as String))
	print("Attack dash lenght " + (current_dash_lenght as String))
	print("Attack position " + (owner.position as String))
	print("Attack target " + (target as String))
	

