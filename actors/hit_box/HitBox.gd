extends Area2D

class_name HitBox

# const DamageSource = preload("res://actors/DamageSource.gd")

func _on_area_entered(area : Area2D):
	if not area is DamageSource:
		return
	owner.take_damage_from(area)

func set_active(value: bool) -> void:
	($CollisionShape2D as CollisionShape2D).disabled = not value

