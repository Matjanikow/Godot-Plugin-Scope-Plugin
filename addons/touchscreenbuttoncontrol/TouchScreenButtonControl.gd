@icon("TouchScreenButtonControl.svg")
class_name TouchScreenButtonControl
extends TextureButton

const DefaultValues := {
	"expand" : true,
	"ignore_texture_size" : true,
	"stretch_mode" : TextureButton.STRETCH_KEEP_ASPECT_CENTERED,
	"action_mode" : TextureButton.ACTION_MODE_BUTTON_PRESS,
	"focus_mode" : TextureButton.FOCUS_NONE,
}

@export var input_action:StringName
@export var use_default_values := true
@export var touchscreen_only := false

var touch_index := 0
var released := true

func _init():
	if use_default_values :
		for k in DefaultValues.keys() :
			self.set(k, DefaultValues.get(k))
	
	if touchscreen_only and not DisplayServer.is_touchscreen_available() :
		hide()

func press():
	var input_event : InputEvent = InputMap.action_get_events(input_action)[0]
	input_event.pressed = true
	Input.parse_input_event(input_event)
	released = false

func release():
	var input_event : InputEvent = InputMap.action_get_events(input_action)[0]
	input_event.pressed = false
	Input.parse_input_event(input_event)
	released = false

func is_in(pos:Vector2) -> bool:
	if int(pos.x) in range(position.x, position.x+size.x) :
		if int(pos.y) in range(position.y, position.y+size.y) :
			return true
	return false

func _input(event):
	if event is InputEventScreenTouch :
		if event.pressed and is_in(event.position) :
			if released :
				touch_index = event.index
			if touch_index == event.index :
				press()
			else :
				release()
		if touch_index == event.index and not event.pressed :
			release()
