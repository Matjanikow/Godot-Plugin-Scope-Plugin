@tool
extends Control

func _on_scope_button_pressed():
	#print(EditorInterface.get_selection().get_selected_nodes()[0].get_path())
	var sceneParent = get_tree().root.find_child("Scene", true, false)
	var sceneEditor = sceneParent.find_child("*SceneTreeEditor*", false, false)
	var tree:Tree = sceneEditor.find_child("*Tree*", false, false)
	if tree.get_selected() != null:
		tree.scroll_to_item(tree.get_selected(), true)
	
