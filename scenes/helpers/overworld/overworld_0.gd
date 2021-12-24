extends Node2D

var preferred_enterance

func _ready():
	$logic/AnimationPlayer.current_animation = "start"
	
	# just in case we start from this scene
	S.control_letterboxing(true)
	AC.play_bg_music("sad")

func after_animation_sequence():
	# FIXME: uncomment this when other stuff works
	SS.save.locations_state.overworld = 1
	S.control_letterboxing(false)
	S.change_scene("overworld", "none", false)
