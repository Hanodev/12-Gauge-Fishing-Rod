class_name Fish
extends CharacterBody3D

@export var NAME = ""
@export var MAX_HP = 10
var HP = MAX_HP
@export var STRENGTH := 10
@export var VALUE := 10
@export var SPEED := 2
@export var WEIGHT := 10
@export var MIN_SIZE_VARIATION: float = 1
@export var MAX_SIZE_VARIATION: float = 2
var target_position: Vector3
var in_water = true
var hooker: CharacterBody3D
var is_whipped = false
var target_velocity = Vector3.ZERO
#What do fish do
#Wander around
#Bite hooks
#try to escape hooks
func _ready() -> void:
	hooker = get_parent().get_node('Player')

func _physics_process(delta: float) -> void:
	if hooker:
		target_position = - (hooker.rod.target.global_position - global_position).normalized()

	else:
		return

	in_water = position.y < 0

	if !is_on_floor() and in_water:
		target_velocity += target_position * SPEED
		velocity.x = move_toward(velocity.x, target_velocity.x, delta * 10)
		velocity.z = move_toward(velocity.z, target_velocity.z, delta * 10)
		if position.y > -1:
			velocity.y = move_toward(velocity.y, -1, delta * 10)
		else:
			velocity.y = move_toward(velocity.y, 1, delta * 10)

	elif !in_water:
		velocity.x = move_toward(velocity.x, 0, delta * 10)

		if is_on_floor():
			velocity.y = move_toward(velocity.y, 0, delta * 10)
		else:
			velocity.y = move_toward(velocity.y, -16, delta * 10)

		velocity.z = move_toward(velocity.z, 0, delta * 10)

	velocity.x = clamp(velocity.x, -50, 50)
	velocity.y = clamp(velocity.y, -50, 50)
	velocity.z = clamp(velocity.z, -50, 50)

	move_and_slide()

func whipped():
	if is_whipped:
		return

	is_whipped = true
	velocity.x = target_position.x * -20
	velocity.y = 20
	velocity.z = target_position.z * -20
	await get_tree().create_timer(.5).timeout
	is_whipped = false

func pulled(PULL_STRENGTH: float) -> void:
	if is_whipped:
		return
	velocity.x = target_position.x * -PULL_STRENGTH
	velocity.z = target_position.z * -PULL_STRENGTH

func apply_damage(damage: int) -> void:
	queue_free();
	return;