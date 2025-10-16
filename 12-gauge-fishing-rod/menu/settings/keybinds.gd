class_name KeybindsPanel
extends Control

@onready var INPUT_BUTTON = preload("res://menu/settings/input_button.tscn")
@onready var action_list = %ActionList
@onready var reset_button: Button = %Reset

#const INPUT_CATEGORY = preload("res://menus/pause/input_category.tscn")
const RESET_WARNING:= "Are you SURE"
const REST_CONFIG_TEXT:= "Reset Configuration"

var is_remapping := false
var action_to_remap = null
var remapping_button = null

var reset_pressed:= false
# First is InputMap, second is in game Label.
var input_actions = {
	## Movement
	'Movement' : '[Movement]',
	"Forward" : "Move Forward",
	"Left" : "Move Left",
	"Backward" : "Move Backward",
	"Right" : "Move Right",
	"Jump" : "Jump",
	'Primary' : 'Primary',
	'Secondary' : 'Secondary',
	'Special' : 'Special',
}

func _ready():
	_load_key_bindings_from_settings()
	_create_action_list()

func _load_key_bindings_from_settings():
	var keybindings = Config.load_key_bindings()
	for action in keybindings.keys():
		if InputMap.has_action(action):
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, keybindings[action])

func _clean_event_text(event: InputEvent) -> String:
	var text = event.as_text()
	text = text.trim_suffix(" (Physical)")
	text = text.trim_suffix(" Button")
	return text

func _create_action_list():
	for item in action_list.get_children():
		item.queue_free()

	for action in input_actions:
		if input_actions[action][0] != '[':
			var button: InputButton = INPUT_BUTTON.instantiate()
			action_list.add_child(button)
			button.label_action.text = input_actions[action]
			var events = InputMap.action_get_events(action)
			if events.size() > 0:
				button.set_input_binding(_clean_event_text(events[0]))
			else:
				button.set_input_binding("")

			button.button.pressed.connect(_on_input_button_pressed.bind(button, action))
func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind NOW."
		button.find_child("LabelInput").modulate = Color(0.8288, 0.5355, 0.8848, 1.0)

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey or
			(event is InputEventMouseButton and event.pressed)
		):

			if event is InputEventMouseButton and event.double_click:
				event.double_click = false

			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap,event)
			Config.save_key_binding(action_to_remap,event)
			_update_action_list(remapping_button,event)

			is_remapping = false
			action_to_remap = null
			remapping_button = null

			accept_event()

func _update_action_list(button,event):
	#button.find_child("LabelInput").text = _clean_event_text(event)
	button.set_input_binding(_clean_event_text(event))
	button.find_child("LabelInput").modulate = Color('white')

func _on_reset_pressed() -> void:
	if not reset_pressed:
		reset_button.text = RESET_WARNING
		reset_pressed = true
		return

	revert_warning()
	InputMap.load_from_project_settings()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			Config.save_key_binding(action,events[0])
	_create_action_list()

func revert_warning() -> void:
	reset_button.text = REST_CONFIG_TEXT
	reset_pressed = false
