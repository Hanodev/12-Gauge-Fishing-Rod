extends Control

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var fish_point: Area2D = %FishPoint
@onready var player_reel: RigidBody2D = %PlayerReel

var upward:= false
var detected:= false
var point_tween: Tween
var fish_tween: Tween
var reel_strength:= 10.0
@onready var fish_sprite: Sprite2D = %FishSprite
@onready var texture_rect: ColorRect = $ProgressBar/TextureRect

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		tween_fish()
		fish_sprite.modulate = Color.CYAN
		upward = true

	elif Input.is_action_just_released(&"Primary"):
		fish_sprite.modulate = Color.WHITE
		upward = false


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(&"Left",&"Right",&"Forward",&"Backward")
	if direction:
		player_reel.apply_central_force(direction * 150.0)


	if detected:
		progress_bar.value += 25.0 * delta
		texture_rect.modulate = lerp(texture_rect.modulate,Color.GREEN,5.0 * delta)
	else:
		progress_bar.value -= 15.0 * delta
		texture_rect.modulate = lerp(texture_rect.modulate,Color.RED,1.0 * delta)

	if progress_bar.value >= progress_bar.max_value:
		hide()
func _on_fish_point_body_entered(body: Node2D) -> void:
	detected = true

func _on_fish_point_body_exited(body: Node2D) -> void:
	detected = false


func _on_timer_timeout() -> void:
	var new_position:= fish_point.position + Vector2(randf_range(-125,125),randf_range(-125,125))
	if new_position.x >= 512.0 or new_position.x <= 0.0:
		new_position.x = fish_point.position.x

	if new_position.y >= 512.0 or new_position.y <= 0.0:
		new_position.y = fish_point.position.y
	if point_tween:
		point_tween.kill()
	point_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	point_tween.tween_property(fish_point,^"position",new_position	,randf_range(0.5,5.0))

func tween_fish() -> void:
	fish_sprite.scale = Vector2.ONE * 0.15
	if fish_tween:
		fish_tween.kill()
	fish_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	fish_tween.tween_property(fish_sprite,^"scale",Vector2.ONE * 0.1,0.15)
