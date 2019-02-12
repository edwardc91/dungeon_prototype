extends TextureProgress

class_name LifeBar

onready var tween = $Tween as Tween

var maximum = 100
var current_health = 0

func initialize(stats_node):
	stats_node.connect('health_changed', self, '_on_Player_Health_health_changed')
	max_value = stats_node.max_health
	current_health = stats_node.health
	animate_bar(current_health)
	
func _on_Player_Health_health_changed(new_health):
	animate_bar(new_health)
	current_health = new_health

func animate_bar(target_health):
	animate_value(current_health, target_health)

func animate_value(start: int, end : int) ->void:
	tween.interpolate_property(self, "value", start, end, 0.5, Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

