@tool
extends EditorPlugin
const SCOPE = preload("res://addons/scope/scopeButton.tscn")
var scope : Control
var menuPanel : Node
func _enter_tree():
	scope = SCOPE.instantiate()
	var sceneParent = get_tree().root.find_child("Scene", true, false)
	menuPanel = sceneParent.find_child("@HBox*", false, false)
	menuPanel.add_child(scope)
	menuPanel.move_child(scope, menuPanel.get_child_count()-2)

func _exit_tree():
	menuPanel.remove_child(scope)
	scope.queue_free()
