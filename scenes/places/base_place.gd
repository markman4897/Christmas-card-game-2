class_name BasePlace
extends Node2D


var preferred_enterance := "none"


func _ready():
	var is_player_present = get_node_or_null("objects/moving/player")
	
	if preferred_enterance != "none" and is_player_present:
		is_player_present.position = get_node("logic/entry_points/"+preferred_enterance).position

func _process(_delta):
	# loop for setting z_index of moving objects
	for node in $objects/moving.get_children():
		_set_z_index(node)
	# HACK... FIXME: make static and moving not relative to each other or something
	for node in $objects/static.get_children():
		_set_z_index(node)


# setts z_index of moving objects to position.y in realtime
func _set_z_index(node:Node):
	if node.get_class() == "Node2D":
		for child in node.get_children():
			_set_z_index(child)
	else:
		node.set_z_index(int(node.position.y))
