extends Node2D

# TODO: test this with weird combinations of dialogue

signal end_state(message)
signal hook(message)

var cursorYpositions := [11, 20, 29]
var cursorYposition = 0
var tween : Tween
var option_slots : Array

var current : String = "start"
# there is probably a smarter way to determine this
var is_animation_playing : bool = false

# modify the variables below when instantiated

var sound = true

var dialogue = {
	"start": {
		"type": "response",
		"text": "sample text here.",
		"next": "1",
		"hook": "has_started"
	},
	"1": {
		"type": "question",
		"text": "one, two or three?",
		"options": [
			{
				"text": "one",
				"next": "start"
			},
			{
				"text": "two",
				"next": "1"
			},
			{
				"text": "three",
				"next": "end"
			}
		]
	},
	"end": {
		"type": "response",
		"text": "end of dialogue.",
		"return": "win"
	}
}

func _ready():
	# prepare for new display
	$text.visible = true
	$options.visible = false
	$text/cursor.visible = false
	$text/text.text = ""
	$options/one.text = ""
	$options/two.text = ""
	$options/three.text = ""
	$options/cursor.position.y = cursorYpositions[0]
	$text/text.percent_visible = 0
	
	option_slots = [$options/one, $options/two, $options/three]
	
	S.disable_player_movement(true)
	
	main()

func _input(event):
	# little helper vars
	var mouse_click_test = (event is InputEventMouseButton and event.button_index == BUTTON_LEFT
			and event.is_pressed())
	var is_input_accept = (event.is_action_pressed("ui_accept") or mouse_click_test)
	
	# if text animation is playing, just end that
	if is_animation_playing:
		if is_input_accept:
			break_animation()
	else:
		if "return" in dialogue[current]:
			if is_input_accept:
				end_textbox()
		
		elif dialogue[current]["type"] == "response":
			if is_input_accept:
				current = dialogue[current]["next"]
				main()
		
		elif dialogue[current]["type"] == "question":
			# HACK: mouse support is done by input events on Area2D's, signal func linked below
			if event.is_action_pressed("ui_down") and cursorYposition < dialogue[current]["options"].size()-1:
				cursorYposition += 1
			elif event.is_action_pressed("ui_up") and cursorYposition > 0:
				cursorYposition -= 1
			elif event.is_action_pressed("ui_accept"):
				current = dialogue[current]["options"][cursorYposition]["next"]
				$options.visible = false
				main()
			
			$options/cursor.position.y = cursorYpositions[cursorYposition]

#
# Signal connections
#

func end_animation():
	if dialogue[current]["type"] == "response":
		$text/cursor.visible = true
	elif dialogue[current]["type"] == "question":
		$options.visible = true
	is_animation_playing = false

# HACK: mouse support mentioned above
func _options_touch(_viewport, event, _shape, option):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if not option >= dialogue[current]["options"].size():
			current = dialogue[current]["options"][option]["next"]
			$options.visible = false
			main()


#
# Other functions
#

func main():
	$text/cursor.visible = false
	$text/text.text = dialogue[current]["text"]
	animate_text($text/text)
	
	# deal with triggers from dialogue
	if dialogue[current].has("hook"):
		emit_signal("hook", dialogue[current]["hook"])
	
	# play voice sounds if enabled
	if sound:
		AC.play_sfx("voice")
	
	if dialogue[current]["type"] == "response":
		$options.visible = false
	
	elif dialogue[current]["type"] == "question":
		for option in option_slots:
			option.text = ""
		
		var i := 0
		for option in dialogue[current]["options"]:
			option_slots[i].text = option.text
			i += 1
		
		cursorYposition = 0
		$options/cursor.position.y = cursorYpositions[cursorYposition]

func animate_text(node, speed:=1.0):
	var length := len(node.text)
	var calculated = length / 15.0
	var animation_duration = calculated/speed
	$tween.remove_all()
	$tween.interpolate_property(node, "percent_visible", 0, 1, animation_duration,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$tween.start()
	is_animation_playing = true

func break_animation():
	$tween.seek($tween.get_runtime())

func end_textbox():
	emit_signal("end_state", dialogue[current]["return"])
	
	S.disable_player_movement(false)
	
	queue_free()
