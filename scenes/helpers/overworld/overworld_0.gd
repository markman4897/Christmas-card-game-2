extends Node2D

func _ready():
	$logic/AnimationPlayer.current_animation = "start"

func after_animation_sequence():
	# FIXME: uncomment this when other stuff works
	SS.save.locations_state.overworld += 1
	S.change_scene("overworld",false)
