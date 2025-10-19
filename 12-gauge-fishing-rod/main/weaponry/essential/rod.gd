class_name Rod
extends Equipment

@export var hooked_fish : Fish
var MIN_THRESHOLD := -1000
var MAX_THRESHOLD := 1000
var THRESHOLD := 0.0
var STRENGTH := 8
var WHIPS := 0
var counter := 0
@onready var target = $target


func activate_equipment(action:= ACTION.PRIMARY, activated:= false) -> void:
	match action:
		ACTION.PRIMARY: _primary_shot(activated)

func _primary_shot(activated:= false) -> void:
	primary_activated.emit()
	if hooked_fish == null:
		return

func _secondary_shot(activated:= false) -> void:
	pass

func _special_shot(activated:= false) -> void:
	pass

func whip():
	#whip causes the fish to fly up into the air. adds a lot of threshold
	if hooked_fish == null:
		return

	if WHIPS<1:
		return

	WHIPS -=1

	hooked_fish.whipped()

func _physics_process(delta: float) -> void:
	if hooked_fish == null:
		return

	if Input.is_action_just_released("Secondary"):
		whip()

	if hooked_fish.in_water:
		THRESHOLD -= hooked_fish.STRENGTH

	if Input.is_action_pressed("Primary"):
		THRESHOLD += STRENGTH
		hooked_fish.pulled(STRENGTH)


	$Label.text = str([MIN_THRESHOLD , ' - ' , THRESHOLD , ' - ' , MAX_THRESHOLD, ' ', WHIPS])
	#
	if THRESHOLD < MIN_THRESHOLD or THRESHOLD > MAX_THRESHOLD:
		hooked_fish = null
		THRESHOLD = 0
	else:
		counter +=1
		if counter == 100:
			if WHIPS < 1:
				WHIPS = 1
			counter = 0

	THRESHOLD = move_toward(THRESHOLD,0.0,delta)
