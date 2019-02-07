extends Node

class_name Steering

const DEFAULT_MASS : float = 2.0
const DEFAULT_SLOW_RADIUS : float = 200.0
const DEFAULT_MAX_SPEED : float = 50.0

func arrive_to(velocity: Vector2,
			   position: Vector2,
			   target_position: Vector2,
			   mass: float,
			   slow_radius: float,
			   max_speed: float) ->Vector2:
	"""
	Calculates and returns a new velocity with the arrive steering behavior arrived based on
	an existing velocity (Vector2), the object's current and target positions (Vector2)
	"""
	var distance_to_target : float = position.distance_to(target_position)

	var desired_velocity : Vector2 = (target_position - position).normalized() * max_speed
	if distance_to_target < slow_radius:
		desired_velocity *= (distance_to_target / slow_radius) * .75 + .25
	var steering : Vector2 = (desired_velocity - velocity) / mass

	return velocity + steering

func follow(velocity: Vector2, 
			position: Vector2,
			target_position: Vector2,
			max_speed: float,
			mass:float=DEFAULT_MASS) ->Vector2:
	var desired_velocity : Vector2 = (target_position - position).normalized() * max_speed

#	var push = calculate_avoid_force(desired_velocity)
#	var steering = (desired_velocity - velocity + push) / mass
	var steering : Vector2 = (desired_velocity - velocity) / mass

	return velocity + steering

