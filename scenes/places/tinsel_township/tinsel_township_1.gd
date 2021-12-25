extends TinselTownship


var elf_text = {
	"start": {
		"type": "response",
		"text": "oh, you're back! thanks again for helping us make a deal, my family hasn't been hungry since.",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "got the kids a new puppy, but to be honest, i'm not entirely sure it's not a wolf.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "eh, we'll figure it out eventually...",
		"return": "none"
	},
}

var elf2_text = {
	"start": {
		"type": "response",
		"text": "i tried to return mayors things back but he refused, said something about besting him at gifting...",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "i don't fully understand it but i do hear his wife crying late at nights. sure hope that's not about their dog.",
		"next": "2"
	},#
	"2": {
		"type": "response",
		"text": "he's truly the definition of a mans best friend, never a dull moment with him.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "anyway, thanks for all the help and merry christmas!",
		"return": "once"
	},
}

var elf2_state := false


func _ready():
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	
	# load music
	AC.play_bg_music("happy")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text)

func _elf2_trigger(_a, _b, _c, _d) -> void:
	if elf2_state:
		S.summon_textBox(self, S.get_random_text())
	else:
		S.summon_textBox(self, elf2_text, "_after_elf2_text")


#
# OTHER FUNCS
#

func _after_elf2_text(arg):
	if arg == "once": 
		elf2_state = true
