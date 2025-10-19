class_name Interactor
extends RayCast3D

signal interaction_detected()
signal interaction_undetected()
signal interactable_interacted()

var interact_body: Interactable

func _input(_event: InputEvent) -> void:
	# Check for interaction input
	if not interact_body: return
	if Input.is_action_just_pressed(&"Interact"):
		interact_body.interact()

func _process(_delta: float) -> void:
	if is_colliding():
		_handle_collision()
	else:
		_handle_no_collision()

func _handle_collision() -> void:
	var collider = get_collider()
	if collider is Interactable:
		if interact_body == null:
			_set_new_interaction(collider)
		elif interact_body != collider:
			_change_interaction(collider)
	else:
		if is_instance_valid(interact_body):
			_end_interaction()

func _handle_no_collision() -> void:
	if is_instance_valid(interact_body):
		_end_interaction()

func _set_new_interaction(new_interactable: Interactable) -> void:
	interact_body = new_interactable
	new_interactable.hover()
	interaction_detected.emit(interact_body)

func _change_interaction(new_interactable: Interactable) -> void:
	interact_body.unhover()
	interaction_undetected.emit(interact_body)
	_set_new_interaction(new_interactable)

func _end_interaction() -> void:
	interaction_undetected.emit(interact_body)
	interact_body.unhover()
	interact_body = null

func check_for_collision() -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is Interactable:
			interaction_detected.emit(collider)
