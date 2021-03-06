extends OnGround

class_name Attack

var current_dash_lenght : float = 0.0

var dash_speed : float = 200
var weapon : Weapon

func _ready()->void:
	weapon = (get_node("../../WeaponPivot/WeaponOffset").get_child(0) as Weapon)
	weapon.connect("combo_finished", self, "_on_Sword_combo_finished")
	weapon.connect("single_attack_started", self, "_on_single_attack_started")

func enter() ->void:
	player_animation_node.play("attack_" + owner.spritedir)
	weapon.attack()
	
func exit() ->void:
	owner.get_body().modulate = Color("#ffffff")
	weapon.set_to_idle_state()
	
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
	

