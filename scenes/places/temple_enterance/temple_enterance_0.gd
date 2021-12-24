extends TempleEnterance


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "question",
		"text": "those eyes! those horrible purple eyes! ohh, the terror! the horror!",
		"options": [
			{
				"text": "what happened!?",
				"next": "1"
			}
		]
	},
	"1": {
		"type": "response",
		"text": "a powerful krampus took santa! snatched him straight out of his workshop! i followed the krampus here",
		"next": "2"
	},
	"2": {
		"type": "question",
		"text": "to this temple, however, i fright to enter.",
		"options": [
			{
				"text": "oh, no!",
				"next": "3"
			},
			{
				"text": "how terrible!",
				"next": "3"
			}
		]
	},
	"3": {
		"type": "question",
		"text": "you need to save him, save santa and save christmas! you're his only hope!",
		"options": [
			{
				"text": "me? you're kidding!",
				"next": "4"
			},
			{
				"text": "wait what? why me?",
				"next": "4"
			}
		]
	},
	"4": {
		"type": "response",
		"text": "silence! now is no time for questions! as it stands, the krampus is far too powerful for even the mightiest of",
		"next": "5"
	},
	"5": {
		"type": "response",
		"text": "our elves, but perhaps might is not the way to beat such a powerful mystic. perhaps… we need someone who is",
		"next": "6"
	},
	"6": {
		"type": "response",
		"text": "the opposite of mighty... we need someone who no one ever notices, someone so dull and uninteresting",
		"next": "7"
	},
	"7": {
		"type": "question",
		"text": "that even the keenest of eagle-eyed eagles would be unable to notice!",
		"options": [
			{
				"text": "hey! watch it!",
				"next": "8"
			},
			{
				"text": "what'm i supposed to do?",
				"next": "8"
			},
			{
				"text": "what do you suggest?",
				"next": "8"
			}
		]
	},
	"8": {
		"type": "response",
		"text": "you must use stealth! that's it! stealth! see that jolly green yule tree to the left of the entrance?", 
		"next": "9"
	},
	"9": {
		"type": "response",
		"text": "the one that resembles all the others? behind it, there lies an ancient passage into the temple",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "unknown to most. put your tepid personality to use and sneak in!",
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
	$logic/portals/overworld_trigger.monitoring = false
	
	# set up red elf
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	
	# load music
	AC.play_bg_music("sad")


#
# SIGNAL HANDLING
#

# should be renamed to _red_trigger or something
func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")


#
# OTHER FUNCS
#

func _after_text(_arg):
	# set other stuff to advance
	$logic/portals/back_enterance_trigger.monitoring = true
