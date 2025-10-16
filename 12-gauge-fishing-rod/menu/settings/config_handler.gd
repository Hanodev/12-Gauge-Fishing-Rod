extends Node

var config:= ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

#[Audio]
var master_volume: float
var music_volume: float
var player_volume: float
var enemy_volume: float
var other_volume: float

#[Keybinds]

# Config Categories
const CONFIG_AUDIO : String = 'Audio'
const CONFIG_VIDEO : String = 'Video'
const CONFIG_KEYBINDS : String = 'Keybinds'

# Config Keys

# AUDIO
const CONFIG_AUDIO_MASTER : String = 'Master'
const CONFIG_AUDIO_MUSIC : String = 'Music'
const CONFIG_AUDIO_SOUND_EFFECTS : String = 'SoundEffects'

# VIDEO Effects
const CONFIG_VIDEO_RETRO : String = 'Retro'
const CONFIG_VIDEO_VHS : String = 'Vhs'
const CONFIG_VIDEO_VINGETTE : String = 'Vignette'
const CONFIG_VIDEO_GLOW : String = 'Glow'
const CONFIG_VIDEO_AMBIENT_FOG : String = 'AmbientFog'
const CONFIG_VIDEO_MOTION_BLUR : String = 'MotionBlur'
const CONFIG_VIDEO_DYNAMIC_FOV : String = 'DynamicFOV'

# VIDEO Main Settings
const CONFIG_VIDEO_MOUSE_SENS : String = 'MouseSensitivity'
const CONFIG_VIDEO_FOV : String = 'FOV'
const CONFIG_VIDEO_CAMERA_SHAKE : String = 'CameraShake'
const CONFIG_VIDEO_FPS_LIMIT : String = 'FPSLimit'
const CONFIG_VIDEO_SHOW_FPS : String = 'ShowFPS'

# KEYBINDS Movement
const CONFIG_KEYBINDS_LEFT : String = 'Left'
const CONFIG_KEYBINDS_RIGHT : String = 'Right'
const CONFIG_KEYBINDS_FORWARD : String = 'Forward'
const CONFIG_KEYBINDS_BACKWARD : String = 'Backward'

# KEYBINDS
const CONFIG_KEYBINDS_JUMP : String = 'Jump'

const CONFIG_KEYBINDS_PRIMARY : String = 'Primary'
const CONFIG_KEYBINDS_SECONDARY : String = 'Secondary'
const CONFIG_KEYBINDS_SPECIAL : String = 'Special'

func _ready() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value(CONFIG_AUDIO,CONFIG_AUDIO_MASTER,0.65)
		config.set_value(CONFIG_AUDIO,CONFIG_AUDIO_MUSIC,0.65)
		config.set_value(CONFIG_AUDIO,CONFIG_AUDIO_SOUND_EFFECTS,0.65)

		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_RETRO,false)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_VHS,true)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_VINGETTE,true)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_GLOW,true)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_AMBIENT_FOG,true)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_MOTION_BLUR,false)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_DYNAMIC_FOV,true)

		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_MOUSE_SENS,0.05)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_FOV,80.0)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_CAMERA_SHAKE,1.0)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_FPS_LIMIT,245)
		config.set_value(CONFIG_VIDEO,CONFIG_VIDEO_SHOW_FPS,false)

		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_LEFT,"A")
		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_RIGHT,"D")
		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_FORWARD,"W")
		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_BACKWARD,"S")

		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_PRIMARY,'mouse_1')
		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_SECONDARY,'mouse_2')
		config.set_value(CONFIG_KEYBINDS,CONFIG_KEYBINDS_SPECIAL,'E')

		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_video_settings(key: String, value) -> void:
	config.set_value('Video',key,value)
	config.save(SETTINGS_FILE_PATH)

func load_video_settings() -> Dictionary:
	var video_settings = {}
	for key in config.get_section_keys('Video'):
		video_settings[key] = config.get_value('Video',key)
	return video_settings

func save_audio_settings(key: String, value) -> void:
	config.set_value('Audio',key,value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings() -> Dictionary:
	var audio_settings = {}
	for key in config.get_section_keys('Audio'):
		audio_settings[key] = config.get_value('Audio',key)
	return audio_settings

func save_key_binding(action: StringName, event: InputEvent):
	var event_str: StringName
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = 'mouse_' + str(event.button_index)

	config.set_value('Keybinds',action,event_str)
	config.save(SETTINGS_FILE_PATH)

func load_key_bindings():
	var keybindings = {}
	var keys = config.get_section_keys('Keybinds')
	for key in keys:
		var input_event
		var event_string = config.get_value('Keybinds',key)

		if event_string.contains('mouse_'):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_string.split('_')[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_string)

		keybindings[key] = input_event
	return keybindings

func _get_keybind_glyph() -> void:
	pass
