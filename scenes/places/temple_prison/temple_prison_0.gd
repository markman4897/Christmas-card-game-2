extends TemplePrison

# this is where the part1 of animation1 happens after talking to santa


var santa_text = {
	"start": {
		"type": "response",
		"text": "boo hoo... i'm locked up and i can't do nothing about it...",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "oh hey! you look like a capable individual, mind helping this sad santa out?",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "break me out! p.l.e.a.s.e!!!",
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
	S.change_scene("temple",false)
