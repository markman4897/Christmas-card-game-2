extends Node2D


#
# VARIABLES
#

var elf_text = [
	"traveller! help!\nwith a storm like this, st. nick won’t be able to deliver any presents!",
	"but there’s still a chance, go into the temple and solve the ancient riddle...",
	"what is the true gift of christmas?",
	"DUMMY TEXT, will not be shown"]
var text_pointer = 0
var text_phase = false


#
# MAIN FUNCS
#

func _ready() -> void:
	# just in case I fuck something up in the editor...
	get_node("elf").disable_input = false
	get_node("textbox").visible = false
	get_node("trigger").monitoring = false
	
	# load music
	var track:AudioStream = load(AudioController.first_track)
	AudioController.play_bg_music(track)

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

# should be renamed to _red_trigger or something
func _elf_trigger(body: Node) -> void:
	get_node("textbox").visible = true
	text_phase = true
	# freeze elf pc
	get_node("elf").disable_input = true
	# start the text thing
	go_through_textbox()

func _on_trigger_body_entered(body: Node) -> void:
	get_node("elf").disable_input = true
	get_node("curtain_animation").set_current_animation("down")

func _on_bg_animation_finished() -> void:
	if get_node("bg").animation == "opening":
		get_node("bg").animation = "opened"

func _on_curtain_animation_animation_finished(anim_name: String) -> void:
	get_tree().change_scene("res://screens/temple.tscn")


#
# OTHER FUNCS
#

# HACK: somehow get this into the textbox script and make it a separate script
func go_through_textbox():
	# print text into the box
	get_node("textbox/text").text = elf_text[text_pointer]
	
	text_pointer += 1
	# check if its the last text
	if text_pointer == elf_text.size():
		after_text()
	else:
		var sfx:AudioStream = load(AudioController.chat)
		AudioController.play_sfx(sfx)

func after_text():
	text_pointer = 0
	text_phase = false
	get_node("textbox").visible = false
	
	# set other stuff to advance
	get_node("elf").disable_input = false
	get_node("trigger").monitoring = true
	if get_node("bg").animation != "opened":
		var sfx:AudioStream = load(AudioController.door_creek)
		AudioController.play_sfx(sfx)
		get_node("bg").animation = "opening"
