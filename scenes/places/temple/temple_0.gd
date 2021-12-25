extends Temple


var big_bad_text = {
	"start": {
		"type": "response",
		"text": "leave . . .",
		"return": "win"
	}
}


func _ready():
	$logic/portals/prison_door.monitoring = false
	$logic/portals/enterance_door.monitoring = false
	
	$objects/moving/big_bad.toggle_flip_h(true)
	$logic/AnimationPlayer.current_animation = "start"
	
	# just in case we start from this scene
	S.control_letterboxing(true)
	AC.play_bg_music("sad")


func after_animation_sequence():
	S.summon_textBox(self, big_bad_text, "_after_text")

func _after_text(_msg):
	SS.save.locations_state.temple = 1
	S.change_scene("overworld", "none", false)
