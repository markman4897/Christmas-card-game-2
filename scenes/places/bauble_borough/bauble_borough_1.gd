extends BaubleBorough


var elf_text = {
	"start": {
		"type": "response",
		"text": "boxes stack good, many joy!",
		"return": "done"
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
