extends Area2D

class_name HitBox

func _on_area_entered(area : Area2D) ->void:
	var damage_source := area as DamageSource
	if not damage_source:
		return
	owner.take_damage_from(damage_source)

func set_active(value: bool) -> void:
	($CollisionShape2D as CollisionShape2D).disabled = not value

