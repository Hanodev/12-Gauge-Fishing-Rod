extends CharacterBody3D


@onready var camera_3d: Camera3D = %Camera3D
@onready var camera_holder: Node3D = $CameraPivot/CameraHolder

@export var jump_strength:= 20.0
@export var gravity:= 22.0
@export var speed:= 8.0
@export var rod : Rod

const mouse_sensitivity:= 0.1

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_holder.rotation.x += deg_to_rad(-event.relative.y) * mouse_sensitivity
		rotation.y += deg_to_rad(-event.relative.x) * mouse_sensitivity

func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector(&"Left",&"Right",&"Forward",&"Backward")
	var direction = transform.basis * Vector3(input_direction.x,0.0,input_direction.y).normalized()

	velocity.x = lerp(velocity.x,direction.x * speed,5.0 * delta)
	velocity.z = lerp(velocity.z,direction.z * speed,5.0 * delta)

	if Input.is_action_just_pressed(&"Jump"):
		velocity.y = jump_strength
	if not is_on_floor():
		velocity.y -= 50.0 * delta
	move_and_slide()
