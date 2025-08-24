@tool
extends EditorPlugin
const SCOPE = preload("res://addons/scope/scopeButton.tscn")
#var dock = "@Panel@14/@VBoxContainer@15/DockHSplitLeftL/DockHSplitLeftR/
#DockVSplitLeftR/DockSlotLeftUR/Scene/@HBoxContainer@5046"
var scope : Control
var menuPanel : Node
var scene_dock : Control

func _enter_tree():
	scope = SCOPE.instantiate()
	#var sceneParent = get_tree().root.find_child("Scene", true, false)
	var sceneParent = null
	for c in get_tree().root.find_children("Scene", "", true, false):
		if c is VBoxContainer: 
			sceneParent = c
			break
	menuPanel = sceneParent.find_child("@HBox*", false, false)
	menuPanel.add_child(scope)
	menuPanel.move_child(scope, menuPanel.get_child_count()-2)
	
func _exit_tree():
	#menuPanel.remove_child(scope)
	remove_control_from_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_LEFT, scope)
	scope.queue_free()
