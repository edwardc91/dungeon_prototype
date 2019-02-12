extends Node

class_name Stats

signal health_changed(new_health)
signal damage_taken(new_health)
signal health_depleted()

var health : int = 0
export(int) var max_health = 9 setget set_max_health
export(int) var strength = 2
export(int) var defense = 0

func _ready() ->void:
	health = max_health

func set_max_health(value: int) ->void:
	max_health = max(0, value)

func take_damage(amount: int) ->void:
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)
	emit_signal("damage_taken", health)
	print("Player Health ", health as String)
	if health == 0:
		emit_signal("health_depleted")

func heal(amount: int) ->void:
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
