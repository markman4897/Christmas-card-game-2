extends BaubleBorough_0


func _init():
	elf_text_2 = {
		"start": {
			"type": "response",
			"text": "you're always welcome to move more boxes.",
			"next": "1"
		},
		"1": {
			"type": "response",
			"text": "i don't know what i can do for compensation but we'll cross that bridge when we get there.",
			"next": "end"
		},
		"end": {
			"type": "response",
			"text": "anyways, merry christmas",
			"return": "none"
		}
	}

func _ready():
	# load music
	AC.play_bg_music("happy")


#
# SIGNAL HANDLING
#

func _elf2_trigger(_a, _b, _c, _d) -> void:
	var random_text = S.get_random_text()
	S.summon_textBox(self, random_text)
