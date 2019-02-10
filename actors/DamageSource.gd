extends Area2D

class_name DamageSource

export(int) var damage = 2
# var effect

func set_active(value: bool) ->void:
	($CollisionShape2D as CollisionShape2D).disabled = not value

