@tool
extends EditorPlugin

#var dock = "@Panel@14/@VBoxContainer@15/DockHSplitLeftL/DockHSplitLeftR/
#DockVSplitLeftR/DockSlotLeftUR/Scene/@HBoxContainer@5046"
var scope : Control
var menuPanel : Node

func _enter_tree():
	_set_scope()
	_add_scope()
	get_tree().root.theme_changed.connect(_theme_changed)
	
func _theme_changed():
	_delete_scope()
	_set_scope()
	_add_scope()

func _set_scope():
	var editorSettings = get_editor_interface().get_editor_settings()
	var baseColor = editorSettings.get_setting("interface/theme/base_color")
	var baseColorLuminance = baseColor.srgb_to_linear().get_luminance()
	var lightMode = baseColorLuminance > 0.5
	var scopePath = "res://addons/scope/scopeButtonLightMode.tscn" if lightMode else "res://addons/scope/scopeButton.tscn"
	var SCOPE = load(scopePath)
	scope = SCOPE.instantiate()
	
func _add_scope():
	var sceneParent = null
	for c in get_tree().root.find_children("Scene", "", true, false):
		if c is MarginContainer: 
			sceneParent = c
			break
	menuPanel = sceneParent.find_child("@HBox*", true, false)
	menuPanel.add_child(scope)
	menuPanel.move_child(scope, menuPanel.get_child_count()-2)

func _delete_scope():
	menuPanel.remove_child(scope)
	scope.queue_free()
	
func _exit_tree():
	_delete_scope()
