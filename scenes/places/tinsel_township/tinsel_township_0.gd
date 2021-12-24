extends TinselTownship


var elf_text = {
	"start": {
		"type": "response",
		"text": "i have a dog!",
		"return": "none"
	}
}

var elf2_text = {
	"start": {
		"type": "response",
		"text": "i got this corn...",
		"return": "none"
	}
}

var elf3_text = {
	"start": {
		"type": "response",
		"text": "where did this chicken come from ?!",
		"return": "none"
	}
}


func _ready():
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	$objects/static/elf3.connect_trigger(self, "_elf3_trigger")
	
	# load music
	AC.play_bg_music("sad")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text)

func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf2_text)

func _elf3_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf3_text)
