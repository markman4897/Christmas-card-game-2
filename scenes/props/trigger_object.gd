class_name TriggerObject
extends Area2D


var interactable = true


#
# Functions
#

func _on_trigger_area_entered(_area: Area2D) -> void:
	if interactable:
		_triggered()

func _triggered():
	# just a placeholder for the actual function
	pass
