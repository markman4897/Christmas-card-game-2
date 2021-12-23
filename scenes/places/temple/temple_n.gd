extends BasePlace

# old version of temple scene, has broken animation transition for some reason...


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "response",
		"text": "why of course, traveller! the real gift of christmas are the people around you!",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "merry christmas!",
		"return": "win"
	}
}

var elf_text_2 = {
	"start": {
		"type": "response",
		"text": "merry christmas!",
		"return": "quo"
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


#
# SIGNAL HANDLING
#

func present_opened(_area):
	present_count += 1
	if present_count == present_total:
		$objects/moving/elf.move_to(Vector2(106,112))

func _elf_trigger(_a, _b, _c, _d) -> void:
	# start the text thing
	if text_mode_2:
		S.summon_textBox(self, elf_text_2, "after_text")
	else:
		S.summon_textBox(self, elf_text, "after_text")


#
# OTHER FUNCS
#

func after_text(arg):
	if arg == "win":
		# only first talk
		$background/bg.animation = "transition"
		text_mode_2 = true
		$background/santa_sleigh.play()
		
		# change the music (pretty sure this belongs here)
		AC.play_bg_music("happy")
