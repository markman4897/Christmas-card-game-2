extends Area2D

class_name TriggerObject


var interactable = true


func _process(_delta):
	self.set_z_index(int(self.position.y))

#
# Functions
#

func _on_trigger_area_entered(_area: Area2D) -> void:
	if interactable:
		_triggered()

func _triggered():
	# just a placeholder for the actual function
	pass
