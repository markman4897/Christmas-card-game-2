extends TempleEnterance


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "response",
		"text": "boo hoo... santa got locked up and i can't do nothing about it...",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "oh hey! you look like a capable individual, mind helping this sad elf out?",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "come, go behind the last evergreen on the left, i'll be right behind you!",
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
	
	# set up red elf
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf.movement_disabled = true
	
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
