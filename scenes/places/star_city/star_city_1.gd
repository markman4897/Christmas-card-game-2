extends StarCity


var elf_text = {
	"start": {
		"type": "response",
		"text": "it's real nice having a friend after all this time.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "merry christmas kid.",
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
	
	yield(get_tree().create_timer(0.5), "timeout")
	$objects/static/elf.disable_collisions_when_moving = true
	$objects/static/elf.connect_end_move(self, "_after_move")
	$objects/static/elf.move_to(Vector2(76,96))


#
# SIGNAL HANDLING
#

# should be renamed to _red_trigger or something
func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text)

# should be renamed to _red_trigger or something
func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, S.get_random_text())

# should be renamed to _red_trigger or something
func _elf3_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, S.get_random_text())
