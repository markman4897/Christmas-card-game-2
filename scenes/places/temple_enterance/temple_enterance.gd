extends BasePlace


#
# VARIABLES
#

var elf_text = {
	"start": {
		"type": "response",
		"text": "traveller! help!\nwith a storm like this, st. nick won’t be able to deliver any presents!",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "but there’s still a chance, go into the temple and solve the ancient riddle...",
		"next": "end",
		"hook": "it works!"
	},
	"end": {
		"type": "response",
		"text": "what is the true gift of christmas?",
		"return": "win"
	}
}


#
# MAIN FUNCS
#

func _ready() -> void:
	# just in case I fuck something up in the editor...
	$logic/doorTrigger.monitoring = false
	
	# set up red elf
	$objects/moving/elf.set_idle_animation("cry")
	$objects/moving/elf.connect_trigger(self, "_elf_trigger")
	$objects/moving/elf.movement_disabled = true
	
	# load music
	AC.play_bg_music("sad")



var test = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		S.control_letterboxing(test)
		test = !test
#
# SIGNAL HANDLING
#

# should be renamed to _red_trigger or something
func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")

func _door_trigger(_body: Node) -> void:
	S.change_scene("temple")

func _on_bg_animation_finished() -> void:
	if $background/bg.animation == "opening":
		$background/bg.animation = "opened"


#
# OTHER FUNCS
#

func _after_text(_arg):
	# set other stuff to advance
	$logic/doorTrigger.monitoring = true
	if $background/bg.animation != "opened":
		AC.play_sfx("door creek")
		$background/bg.animation = "opening"
