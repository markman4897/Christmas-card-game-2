extends Temple


func _ready():
	$objects/moving/big_bad.toggle_flip_h(true)
	$logic/AnimationPlayer.current_animation = "start"


func after_animation_sequence():
	# FIXME: uncomment this when other stuff works
	#SS.save.locations_state.temple += 1
	S.change_scene("overworld", false)
