extends Node

signal fish(strength: float)

@onready var area_2d: RigidBody2D = $Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

var targeted:= false
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		if ray_cast_2d.is_colliding():
			area_2d.linear_velocity = Vector2.ZERO
			area_2d.apply_central_impulse(Vector2.UP * 525.0)

func _physics_process(delta: float) -> void:
	if ray_cast_2d_2.is_colliding():
		fish.emit(area_2d.linear_velocity.length())
		area_2d.freeze = true
		return

	if ray_cast_2d.is_colliding():
		area_2d.modulate = Color.GREEN
	else:
		area_2d.modulate = Color.WHITE
