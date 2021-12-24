class_name BaubleBorough
extends BasePlace


#
# Signals
#

func _door_trigger(_body: Node) -> void:
	S.change_scene("sokoban")

func _overworld_trigger(_body: Node) -> void:
	S.change_scene("overworld", "bauble_borough")
