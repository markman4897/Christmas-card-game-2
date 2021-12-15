tool
extends TriggerObject


export(int) var frame = 0 setget set_frame
export(bool) var flipped = false setget set_flipped


#
# Functions to be used from outside
#

func _triggered():
	AudioController.play_sfx("present open")
	$sprite.frame += 4
	interactable = false
	
	# chimp blooper
	Singleton.chimp_code.append($sprite.frame)
	if Singleton.chimp_code == Singleton.chimp_code_solution:
		Singleton.summon_chimp(self)

func set_frame(new_frame):
	frame = new_frame
	$sprite.frame = frame

func set_flipped(new_state):
	flipped = new_state
	$sprite.flip_h = flipped

# FIXME: this should really be merged with present.gd if its gonna be used
