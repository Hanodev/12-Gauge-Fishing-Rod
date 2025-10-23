extends Node

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _process(delta: float) -> void:
	label.text = "GAMEPLAY: " + str(floori(timer.time_left))

func _on_timer_timeout() -> void:
	get_tree().quit()
