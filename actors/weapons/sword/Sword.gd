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
	
	._ready()


