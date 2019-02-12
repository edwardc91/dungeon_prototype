extends Weapon

class_name Sword
	
func _ready() ->void:
	combo = [
	{
		'damage': 1,
		'animation': 'fast_attack',
		'dash_lenght': 10,
	},
	{
		'damage': 1,
		'animation': 'fast_attack',
		'dash_lenght': 10,
	},
	{
		'damage': 3,
		'animation': 'medium_attack',
		'dash_lenght': 10,
	}]
	
	weapon_damage_source = preload("res://actors/weapons/sword/SwordDamageSource.tscn")
	._ready()
	
func instantiate_damage_source():
	dm_instance = weapon_damage_source.instance()
	dm_instance.damage = current_damage
	add_child(dm_instance)
	
func destroy_damage_source():
	if dm_instance:
		dm_instance.monitoring = false
		dm_instance.queue_free()
		dm_instance = null
	


