extends Node2D


#
# VARIABLES
#

var elf_text = [
	"why of course, traveller! the real gift of christmas are the people around you!",
	"merry christmas!",
	"DUMMY TEXT, will not be shown"]
var elf_text_2 = ["merry christmas!","DUMMY TEXT, will not be shown"]
var text_pointer = 0
var text_phase = false
var text_mode_2 = false

# FIXME! Why U no work?!
#var present_total = get_node("presents").get_children()
# HACK -.-
var present_total = 2
var present_count = 0

onready var bg = get_node("bg")

var chimp = []
var chimp_code = [5,4,3,1,1,0]

#
# MAIN FUNCS
#

func _ready() -> void:
	# just in case I fuck something up in the editor...
	get_node("elf").disable_input = false
	get_node("textbox").visible = false
	get_node("santa").visible = false
	get_node("curtain_animation/curtain").visible = true
	get_node("chimp").visible = false
	
	get_node("curtain_animation").set_current_animation("up")
	
	# link all presents frame changed signals to "present_opened()" func
	# TODO this ^^

# just for the text phase
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and text_phase:
		if event.scancode == KEY_SPACE:
			go_through_textbox()
	# for touch
	if event is InputEventMouseButton and event.pressed and text_phase:
		go_through_textbox()


#
# SIGNAL HANDLING
#

# ensures the night animation goes after transition animation
func _on_bg_animation_finished() -> void:
	if bg.animation == "transition":
		bg.animation = "night"

func present_opened():
	present_count += 1
	if present_count == present_total:
		move_red()

func _on_red_walk_tween_completed(object: Object, key: NodePath) -> void:
	get_node("red").animation = "idle"

func _on_trigger_body_entered(body: Node) -> void:
	get_node("textbox").visible = true
	text_phase = true
	# freeze elf pc
	get_node("elf").disable_input = true
	# start the text thing
	go_through_textbox()


#
# OTHER FUNCS
#

func move_red():
	var tween = get_node("red_walk")
	tween.interpolate_property($red, "position",
		Vector2(106, 128), Vector2(106, 96), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

# HACK: somehow get this into the textbox script and make it a separate script
func go_through_textbox():
	# print text into the box
	get_node("textbox/text").text = elf_text[text_pointer]
		
	var sfx:AudioStream = load(AudioController.chat)
	AudioController.play_sfx(sfx)
	
	text_pointer += 1
	# check if its the last text
	if text_pointer == elf_text.size():
		text_pointer = 0
		text_phase = false
		get_node("textbox").visible = false
		
		# set other stuff to advance
		get_node("elf").disable_input = false
		get_node("santa").visible = true
		
		if !text_mode_2:
			# only first talk
			bg.animation = "transition"
			elf_text = elf_text_2
			text_mode_2 = true
			# change the music (pretty sure this belongs here)
			var track:AudioStream = load(AudioController.second_track)
			AudioController.play_bg_music(track)
