@tool
extends EditorPlugin

var MyCustomNode = preload("res://addons/touchscreenbuttoncontrol/TouchScreenButtonControl.gd")

func _enter_tree():
	add_custom_type("TouchScreenButtonControl", "Control", TouchScreenButtonControl, preload("res://addons/touchscreenbuttoncontrol/TouchScreenButtonControl.svg"))

func _exit_tree():
	remove_custom_type("TouchScreenButtonControl")
