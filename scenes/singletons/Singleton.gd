extends Node


#
# Constants
#

# preload scenes
const tween := preload("res://scenes/singletons/tween.tscn")

const scenes := {
	"menu": [
		preload("res://scenes/helpers/menu/menu.tscn"),
	],
	"overworld": [
		preload("res://scenes/helpers/overworld/overworld_0.tscn"),
		preload("res://scenes/helpers/overworld/overworld_1.tscn"),
	],
	"temple_enterance": [
		preload("res://scenes/places/temple_enterance/temple_enterance_0.tscn"),
		preload("res://scenes/places/temple_enterance/temple_enterance_1.tscn"),
		preload("res://scenes/places/temple_enterance/temple_enterance_2.tscn"),
	],
	"temple_prison": [
		preload("res://scenes/places/temple_prison/temple_prison_0.tscn"),
		preload("res://scenes/places/temple_prison/temple_prison_1.tscn"),
	],
	"temple": [
		preload("res://scenes/places/temple/temple_0.tscn"),
		preload("res://scenes/places/temple/temple_1.tscn"),
		preload("res://scenes/places/temple/temple_2.tscn"),
	],
	"bauble_borough": [
		preload("res://scenes/places/bauble_borough/bauble_borough_0.tscn"),
		preload("res://scenes/places/bauble_borough/bauble_borough_1.tscn"),
	],
	"sokoban": [
		preload("res://scenes/helpers/sokoban/sokoban_0.tscn"),
	],
	"tinsel_township": [
		preload("res://scenes/places/tinsel_township/tinsel_township_0.tscn"),
		preload("res://scenes/places/tinsel_township/tinsel_township_1.tscn"),
	],
	"star_city": [
		preload("res://scenes/places/star_city/star_city_0.tscn"),
		preload("res://scenes/places/star_city/star_city_1.tscn"),
	],
}

# preload helpers, if there will be more than 2 it should be a const like scenes
const textBox := preload("res://scenes/helpers/text_box/text_box.tscn")
const curtain := preload("res://scenes/helpers/curtain/curtain.tscn")
const letterboxing := preload("res://scenes/helpers/letterboxing/letterboxing.tscn")

const random_texts := [
	"this blows!",
	"i don't know what i'm gonna do without christmas.",
	"you got some change for the vending machine? it doesn't accept notes.",
	"i heard fruitcake makes you fat, but doesn't the fruit cancel out the cake?",
	"you have a resting grinch face, you know that?",
	"sleigh, queen, sleigh. yass!",
	"christmas is ruing, but wait! there's myrrh!",
	"don't cross me or yule be sorry.",
	"i like to have the final sleigh in things.",
	"it's the most wonderful time for a beer.",
	"i'm feeling a bit claus-trophobic.",
	"time to spruce things up!",
	"i may not look okay, but i assure you i'm pine.",
	"it's ice to meet you.",
	"treat your elf, gurl.",
]


onready var root := get_tree().get_root()
var Curtain : Node


#
# Variables
#

var debug := true

var audio_singleton_loaded := false
# maybe add this for screen switching if necessary
# var screen_loaded := false

var current_scene : Node
var player : Node

# HACK: should be replaced with more sophisticated input handling
# there has to be a way around this man... CMON!
# rn its only used for textbox so that the player can't move
var player_movement_disabled := false


func _ready():
	# Get first screen
	# HACK: yeah... it is kinda hacky... I'll admit it...
	#       I tried to run Singleton.tscn as "application/run/main_scene" but I
	#       got a "cyclic reference" error no matter how I went about it...
	#       ... maybe next time I'll get it right from the start...
	current_scene = root.get_node_or_null("menu")
	
	# this is just for debugging, when you don't start the game from the menu
	if !current_scene:
		current_scene = root.get_children()[root.get_child_count()-1]
	
	# load save file
	SS.load_from_file()
	
	# set variables from saved
	AC.set_music_volume(SS.save.music_volume)
	AC.set_ambiance_volume(SS.save.ambiance_volume)
	AC.set_sfx_volume(SS.save.sfx_volume)


#
# Summon functions
#

func change_scene(scene:String, preferred_enterance:String="none", curtain:=true):
	var is_curtain_present = root.get_node_or_null("curtain")
	
	# Disable input while switching scenes
	# FIXME: this only works on menu screen?! what?! (function below)
	#        aha... this only works for control nodes?
	#        https://godotengine.org/qa/22076/solved-enable-disable-input-entire-application-from-gdscript
	disable_input(true)
	# HACK: until I fix the above line to work everywhere -.-
	#       probably by inserting control node that takes the whole screen and
	#       then deleting it when we wanna enable it back... idk, seems like an
	#       ugly fix and idk how to make sure its always on top even if I spawn
	#       more things after I summon that control element
	#       OR I can try to do it with get_tree().set_pause(true) but idk if I
	#       want to pause everything necessarily...
	disable_player_movement(true)
	
	if curtain and !is_curtain_present:
		control_curtain("close")
		yield(Curtain, "done")
		is_curtain_present = true
	
	# save settings
	SS.save_to_file()
	
	current_scene.queue_free()
	
	# if we iterated scene too far or came to the last scene change
	if SS.save.locations_state[scene] >= scenes[scene].size():
		error("SS.save", '"'+scene+'" got over iterated '+str(SS.save.locations_state[scene]))
		SS.save.locations_state[scene] = scenes[scene].size()-1
	
	if scene != "menu":
		SS.save.last_location = scene
	
	var new_scene = scenes[scene][SS.save.locations_state[scene]].instance()
	new_scene.preferred_enterance = preferred_enterance
	
	root.call_deferred("add_child", new_scene)
	current_scene = new_scene
	
	player = current_scene.find_node("player")
	
	if curtain:
		control_curtain("open")
	
	# Enable movement after switching scene
	disable_input(false)
	# HACK: until I fix the above line to work everywhere -.-
	disable_player_movement(false)

func summon_textBox(node:Node, dialogue:Dictionary={}, connect_end_signal_to:String="none",
		connect_hook_signal_to:String="none", sound:bool=true):
	var textBoxInstance = textBox.instance()
	
	textBoxInstance.dialogue = dialogue
	
	if !sound:
		# this could be "= sound" but it's unnecessary
		textBoxInstance.sound = false
	
	if connect_end_signal_to != "none":
		textBoxInstance.connect("end_state", node, connect_end_signal_to)
	
	if connect_hook_signal_to != "none":
		textBoxInstance.connect("hook", node, connect_hook_signal_to)
	
	node.call_deferred("add_child", textBoxInstance)
	
	return textBoxInstance

# this just got ugly...
func control_curtain(direction:String, connect_signal_to:String="none", node:=Node):
	# check if we want to close the curtain and if there is a curtain already present
	if direction == "close" and root.get_node_or_null("curtain") == null:
		Curtain = curtain.instance()
		root.add_child(Curtain) # DON'T CALL WITH "call_deferred" !
	
	if connect_signal_to != "none":
		var _void = Curtain.connect("done", node, connect_signal_to)
	
	Curtain.run(direction)

func control_letterboxing(state:bool):
	var is_letterboxing_present := root.get_node_or_null("letterboxing")
	
	if state and !is_letterboxing_present:
		root.call_deferred("add_child", letterboxing.instance())
	elif !state and is_letterboxing_present:
		is_letterboxing_present.queue_free()

func summon_tween(node:Node, property:String, value_start, value_end, duration:float,
		callback:="none", trans_val:=Tween.TRANS_LINEAR, ease_val:=Tween.EASE_IN_OUT):
	var tweenInstance = tween.instance()
	tweenInstance.interpolate_property(node, property, value_start, value_end,
			duration, trans_val, ease_val)
	if callback != "none":
		tweenInstance.connect("done", node, callback)
	node.add_child(tweenInstance)
	tweenInstance.start()
	
	return tween

func summon_animated_sprite(node:Node, frames:String, position:Vector2):
	var sprite = AnimatedSprite.new()
	sprite.frames = load(frames)
	sprite.position = position
	sprite.playing = true
	node.add_child(sprite)
	
	return sprite


#
# Other functions
#

func get_random_text() -> Dictionary:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var dict = {
		"start": {
			"type": "response",
			"text": random_texts[rng.randi_range(0,random_texts.size()-1)],
			"return": "none"
		}
	}
	
	return dict

func disable_input(state:bool):
	root.set_disable_input(state)

func disable_player_movement(state:bool):
	if player != null and "movement_disabled" in player:
		player.movement_disabled = state

func error(function:String, message:String):
	print("ERR: ", function, " | ", message)


#
###
#####

# Bloopers

var chimp_code := []
var chimp_code_solution := [5,4,3,1,1,0]

func summon_chimp(node:Node):
	var sprite = summon_animated_sprite(node, "res://assets/aseprite_files/random/chimp.ase", Vector2(64,64))
	sprite.z_index = 2000
#####
###
#
