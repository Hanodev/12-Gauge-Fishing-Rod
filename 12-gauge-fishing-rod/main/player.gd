class_name Player extends CharacterBody3D

@onready var camera_3d: Camera3D = %Camera3D

@export var camera_base: Node3D;
@export var vfx_base: Shaker;

@export var jump_strength := 20.0
@export var gravity := 22.0
@export var speed := 8.0
@export var rod: Rod

const mouse_sensitivity := 0.1

var view_angles: Vector3;

func _enter_tree() -> void:
	Manager.player = self;
	return;

func _exit_tree() -> void:
	Manager.player = null;
	Manager.player_vision_cast = null;
	return;

func _ready() -> void:
	Manager.player_vision_cast = %VisionCast;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion: Vector2 = event.screen_relative * mouse_sensitivity * (PI / 180.0);
		view_angles.x = clampf(view_angles.x - motion.y, -PI, PI);
		view_angles.y = wrapf(view_angles.y - motion.x, 0, TAU)
		camera_base.quaternion = Quaternion.from_euler(view_angles);

func _process(delta: float) -> void:
	camera_base.global_position = get_global_transform_interpolated().origin + Vector3.UP * 0.6;
	return;

func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector(&"Left", &"Right", &"Forward", &"Backward")
	var direction = Basis(Vector3.UP, view_angles.y) * Vector3(input_direction.x, 0.0, input_direction.y);

	velocity.x = lerp(velocity.x, direction.x * speed, 5.0 * delta)
	velocity.z = lerp(velocity.z, direction.z * speed, 5.0 * delta)

	if Input.is_action_just_pressed(&"Jump"):
		velocity.y = jump_strength
	if not is_on_floor():
		velocity.y -= 50.0 * delta
	move_and_slide()
