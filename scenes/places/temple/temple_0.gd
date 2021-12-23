extends Temple


func _ready():
	$objects/moving/big_bad.toggle_flip_h(true)
	$logic/AnimationPlayer.current_animation = "start"
	
	# just in case we start from this scene
	S.control_letterboxing(true)


func after_animation_sequence():
	SS.save.locations_state.temple += 1
	S.change_scene("overworld", false)
