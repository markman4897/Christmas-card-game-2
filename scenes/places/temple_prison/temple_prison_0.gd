extends TemplePrison

# this is where the part1 of animation1 happens after talking to santa


var santa_text = {
	"start": {
		"type": "question",
		"text": "weep! weep! egads! a friendly, but otherwise very humdrum elf has come to my aid! help!",
		"options": [
			{
				"text": "guy, i'm tryin' to help ya",
				"next": "1"
			}
		]
	},
	"1": {
		"type": "response",
		"text": "you have to free me, i beg you! see those three locks on the jail gate? you need special keys to",
		"next": "2"
	},
	"2": {
		"type": "response",
		"text": "unlock them! each key is to be found in one of the settlements scattered all around the mountain.",
		"next": "3"
	},
	"3": {
		"type": "response",
		"text": "find them... wait, what was that?!",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "r u n !!!",
		"return": "win"
	}
}


#
# MAIN FUNCS
#

func _ready() -> void:
	# just in case I fuck something up in the editor...
	$logic/portals/door_trigger.monitoring = false
	$logic/portals/back_enterance_trigger.monitoring = false
	
	# set up santa and big bad
	$objects/static/santa.connect_trigger(self, "_santa_trigger")
	$objects/static/santa.movement_disabled = true
	$objects/moving/big_bad.is_actor = true
	
	# just in case we start from this scene
	AC.play_bg_music("sad")
	
	SS.save.locations_state.temple_enterance = 1


func _santa_trigger(_a, _b, _c, _d):
	S.summon_textBox(self, santa_text, "_after_text")


#
# OTHER FUNCS
#

func _after_text(_arg):
	S.control_letterboxing(true)
	$logic/AnimationPlayer.current_animation = "start"

func after_animation_sequence():
	SS.save.locations_state.temple_prison = 1
	S.change_scene("temple", "none", false)
