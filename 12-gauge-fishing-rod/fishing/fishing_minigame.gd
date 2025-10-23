extends Control

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var fish_point: Area2D = %FishPoint
@onready var player_reel: RigidBody2D = %PlayerReel

var upward:= false
var detected:= false
var point_tween: Tween
var fish_tween: Tween
@onready var fish_sprite: Sprite2D = %FishSprite
@onready var texture_rect: ColorRect = $ProgressBar/TextureRect

func _ready() -> void:
	print(progress_bar.size.x)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"Primary"):
		upward = true
		tween_fish()
		fish_sprite.modulate = Color.CYAN
	elif Input.is_action_just_released(&"Primary"):
		upward = false
		fish_sprite.modulate = Color.WHITE


func _physics_process(delta: float) -> void:
	if upward:
		player_reel.apply_central_force(Vector2.RIGHT * 150.0)
	else:
		player_reel.apply_central_force(Vector2.LEFT * 150.0)
	
	if detected:
		progress_bar.value += 25.0 * delta
		texture_rect.modulate = lerp(texture_rect.modulate,Color.GREEN,5.0 * delta)
	else:
		progress_bar.value -= 15.0 * delta
		texture_rect.modulate = lerp(texture_rect.modulate,Color.RED,1.0 * delta)

func _on_fish_point_body_entered(body: Node2D) -> void:
	detected = true

func _on_fish_point_body_exited(body: Node2D) -> void:
	detected = false


func _on_timer_timeout() -> void:
	var new_position:= fish_point.position.x + randf_range(-100.0,100.0)
	if new_position >= 512.0 or new_position <= 0.0:
		new_position = fish_point.position.x
	if point_tween:
		point_tween.kill()
	point_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	point_tween.tween_property(fish_point,^"position:x",new_position,randf_range(0.5,2.0))

func tween_fish() -> void:
	fish_sprite.scale = Vector2.ONE * 0.15
	if fish_tween:
		fish_tween.kill()
	fish_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	fish_tween.tween_property(fish_sprite,^"scale",Vector2.ONE * 0.1,0.15)
