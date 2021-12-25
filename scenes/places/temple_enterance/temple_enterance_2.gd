extends TempleEnterance


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "response",
		"text": "yay! you saved christmas and mr santa himself",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "mr krampus is calling you in, that's a first!",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "go on then, and merry christmas",
		"return": "win"
	}
}


#
# MAIN FUNCS
#

func _ready() -> void:
	# set up red elf
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	
	# load music
	AC.play_bg_music("happy")


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
	$logic/portals/door_trigger.monitoring = true
	if $background/bg.animation != "opened":
		AC.play_sfx("door creek")
		$background/bg.animation = "opening"
