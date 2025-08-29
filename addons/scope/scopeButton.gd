@tool
extends Control

func _on_scope_button_pressed():
	var sceneParent = null
	for c in get_tree().root.find_children("Scene", "", true, false):
		if c is VBoxContainer: 
			sceneParent = c
			break
	var sceneEditor = sceneParent.find_child("*SceneTreeEditor*", false, false)
	var tree:Tree = sceneEditor.find_child("*Tree*", false, false)
	if tree.get_selected() != null:
		tree.scroll_to_item(tree.get_selected(), true)
		
	# Expandir automáticamente todos los padres hasta el nodo seleccionado en el SceneTree
	var selected := tree.get_selected()
	if selected == null:
		return
	var path_items: Array = []
	var current := selected
	while current:
		path_items.append(current)
		current = current.get_parent()
	path_items.reverse()
	
	for item in path_items:
		item.set_collapsed(false) 
	tree.scroll_to_item(selected, true)
	tree.queue_redraw()
