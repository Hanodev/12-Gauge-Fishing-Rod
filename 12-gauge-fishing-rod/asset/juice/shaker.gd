extends Node3D
class_name Shaker

@export var trauma_reduction_rate = 1.0
@export var camera_shake:= false
@export var noise: FastNoiseLite = FastNoiseLite.new()
@export var noise_speed = 10.0

var trauma = 0.0

@export_group("Maximum Values")
@export var max_x = 45.0
@export var max_y = 25.0
@export var max_z = 25.0

@export var traumua_target:= 0.1
@export var maximum_trauma:= 1.0
var time = 0.0

@onready var initial_rotation = self.rotation_degrees as Vector3
var x_seed: int = 1
var y_seed: int = 2
var z_seed: int = 3

func _ready() -> void:
	x_seed = randi_range(1,128)
	y_seed = randi_range(1,128)
	z_seed = randi_range(1,128)

	if camera_shake:
		Manager.camera_shaked.connect(add_trauma)

func _physics_process(delta):
	trauma = max(trauma - delta * trauma_reduction_rate,traumua_target)
	time += delta
	if trauma:
		self.rotation_degrees.x = initial_rotation.x + max_x * get_shake_intensity() * get_noise_from_seed(x_seed)
		self.rotation_degrees.y = initial_rotation.y + max_y * get_shake_intensity() * get_noise_from_seed(y_seed)
		self.rotation_degrees.z = initial_rotation.z + max_z * get_shake_intensity() * get_noise_from_seed(z_seed)

func add_trauma(trauma_amount : float = 0.8):
	var max_clamp = maximum_trauma
	trauma = clamp(trauma + trauma_amount, 0.0, max_clamp)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)

func apply_camera_shake() -> void:
	Manager.apply_camera_shake()

func apply_fov_change() -> void:
	Manager.camera_fov_changed.emit(90.0)
