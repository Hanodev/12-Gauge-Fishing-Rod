class_name InputButton
extends Control
@onready var label_input: RichTextLabel = $MarginContainer/HBoxContainer/LabelInput
@onready var button: Button = $Button
@onready var label_action: Label = %LabelAction

var action_text: String
func _ready() -> void:
	mouse_entered.connect(hovered.bind(true))
	mouse_exited.connect(hovered.bind(false))
	
func set_action(text: String) -> void:
	action_text = text
	if label_action:
		label_action.text = action_text

func hovered(da_hovered: bool) -> void:
	if da_hovered: modulate = Color(0.3333, 0.7843, 0.7843, 1.0)
	else: modulate = Color('WHITE')

func set_input_binding(input_string: String) -> void:
	label_input.text = ""
	label_input.add_text(input_string)
