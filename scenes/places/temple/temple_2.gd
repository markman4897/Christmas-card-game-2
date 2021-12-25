extends Temple

# old version of temple scene


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "response",
		"text": "hey now! these are not all for you, you know! leave some for the rest of us.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "but still, merry christmas.",
		"return": "first"
	}
}

var elf_text_2 = {
	"start": {
		"type": "response",
		"text": "merry christmas.",
		"return": "none"
	}
}

var text_mode_2 = false

var present_total = 2
var present_count = 0


#
# MAIN FUNCS
#

func _ready() -> void:
	$objects/moving/elf.connect_trigger(self, "_elf_trigger")
	$objects/moving/elf.disable_collisions_when_moving = true
	
	for present in $objects/static/presents.get_children():
		present.connect("area_entered", self, "present_opened")
	
	# load music
	AC.play_bg_music("happy")


#
# SIGNAL HANDLING
#

func present_opened(_area):
	present_count += 1
	if present_count == present_total:
		$objects/moving/elf.move_to(Vector2(106,112))

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")


#
# Other functions
#

func _after_text(arg):
	if arg == "first":
		elf_text = elf_text_2
