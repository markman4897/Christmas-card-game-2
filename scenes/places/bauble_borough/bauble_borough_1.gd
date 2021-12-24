extends BaubleBorough


var elf_text = {
	"start": {
		"type": "response",
		"text": "due to various troubles having to do with my finances, i am at this moment unable to provide you",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "with anything costing over 25c. so, here’s a 10c gift certificate to any star sandwiches establishment.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "also, here’s this old key i found in the city hall.",
		"return": "none"
	}
}


func _ready():
	# set up elf
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	
	# load music
	AC.play_bg_music("happy")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text)
