extends Temple


func _ready():
	$objects/moving/big_bad.toggle_flip_h(true)
	$logic/AnimationPlayer.current_animation = "start"
	
	# just in case we start from this scene
	S.control_letterboxing(true)
	AC.play_bg_music("sad")


func after_animation_sequence():
	SS.save.locations_state.temple = 1
	S.change_scene("overworld", false)
