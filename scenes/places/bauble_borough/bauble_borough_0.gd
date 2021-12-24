extends BaubleBorough


var elf_text = {
	"start": {
		"type": "response",
		"text": "boo hoo... boxes stack bad, me so sad",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "oh hey! you look like a capable individual, mind helping this sad elf out?",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "come, stack the boxes in my house please",
		"return": "prompt_over"
	}
}

var elf2_text = {
	"start": {
		"type": "response",
		"text": "see that guy over there?",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "he's been whining for days now, noone can get him to stop",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "it's super annoying...",
		"return": "prompt_over"
	}
}

func _ready():
	$logic/portals/door_trigger.monitoring = false
	
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	
	# load music
	AC.play_bg_music("sad")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")

func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf2_text)


#
# OTHER FUNCS
#

func _after_text(arg):
	if arg == "prompt_over":
		$background/bg.play("door_open")
		$logic/portals/door_trigger.monitoring = true
