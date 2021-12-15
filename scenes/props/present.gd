tool
extends TriggerObject


# HACK: ugh... Is there really no other way than to make this a tool
#       it just doesn't feel right to do this man...
#       I guess there isn't...
export(int) var frame = 0 setget set_frame
export(bool) var flipped = false setget set_flipped


#
# Signals
#

func _on_trigger_area_entered(_area: Area2D) -> void:
	if interactable:
		# chimp blooper
		Singleton.chimp_code.append($sprite.frame)
		if Singleton.chimp_code == Singleton.chimp_code_solution:
			Singleton.summon_chimp(self)
		
		AudioController.play_sfx("present open")
		$sprite.frame += 6
		interactable = false


#
# Functions to be used from outside
#

func set_frame(new_frame):
	frame = new_frame
	$sprite.frame = frame

func set_flipped(new_state):
	flipped = new_state
	$sprite.flip_h = flipped
