class_name BasePlace
extends Node2D


func _process(_delta):
	# loop for setting z_index of moving objects
	for node in $objects/moving.get_children():
		_set_z_index(node)


# setts z_index of moving objects to position.y in realtime
func _set_z_index(node:Node):
	if node.get_class() == "Node2D":
		for child in node.get_children():
			_set_z_index(child)
	else:
		node.set_z_index(int(node.position.y))
