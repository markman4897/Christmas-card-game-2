extends Node


var music_dict := {
	"sad": preload("res://assets/music/songs/MerryXmas.ogg"),
	"happy": preload("res://assets/music/songs/Jingle.ogg")
}

var sfx_dict := {
	"voice": preload("res://assets/music/sfx/chat.ogg"),
	"door creek": preload("res://assets/music/sfx/door_creek.ogg"),
	"present open": preload("res://assets/music/sfx/present_open.ogg")
}


onready var bg_music_tracks := [$bg_music_0, $bg_music_1]
var current_bg_music_track := 0

var bg_music_volume_db := 0.0
var bg_music_volume_p := 1.0

const bg_music_transition_time := 2.0


onready var sfx_tracks := [$sfx_0, $sfx_1, $sfx_2, $sfx_3, $sfx_4]
var current_sfx_track := 0

var sfx_volume_db := 0.0
var sfx_volume_p := 1.0


func _ready():
	# ping Singleton that this scene is operational
	# HACK: I'm not sure this is 100% sure to happen after Singleton is already loaded
	#       lets check that out soon yeah?
	Singleton._void = connect("ready", Singleton, "audio_singleton_is_on")


#
# Functions
#


func get_next(array:Array, pointer:int):
	var size = array.size()-1
	if pointer + 1 > size:
		return 0
	else:
		return pointer + 1

func play_bg_music(song:String):
	# get next track
	var next_track = get_next(bg_music_tracks, current_bg_music_track)
	
	# set it up
	# FIXME: move this so it stopps after fade out
	bg_music_tracks[next_track].stop()
	bg_music_tracks[next_track].volume_db = -80.0
	bg_music_tracks[next_track].stream = music_dict[song]
	
	# play it
	bg_music_tracks[next_track].play()
	# fade old one out
	Singleton.summon_tween(bg_music_tracks[current_bg_music_track], "volume_db", bg_music_volume_db,
			-80.0, bg_music_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_IN)
	# fade new one in
	Singleton.summon_tween(bg_music_tracks[next_track], "volume_db", -80.0, bg_music_volume_db,
			 bg_music_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_OUT)
	current_bg_music_track = next_track

func play_sfx(sound:String):
	# get next track
	var next_track = get_next(sfx_tracks, current_sfx_track)
	
	# set it up
	sfx_tracks[next_track].stop()
	sfx_tracks[next_track].volume_db = sfx_volume_db
	sfx_tracks[next_track].stream = sfx_dict[sound]
	
	# play it
	sfx_tracks[next_track].play()
	current_sfx_track = next_track


func get_music_volume(type:="percent"):
	match type:
		"percent":
			return bg_music_volume_p
		"db":
			return bg_music_volume_db
		_:
			Singleton.error("get_music_volume", "arg type has a typo")

func set_music_volume(volume:float, type:="percent"):
	var db : float
	var percent : float
	
	match type:
		"percent":
			db = linear2db(volume)
			percent = volume
		"db":
			db = volume
			percent = db2linear(volume)
		_:
			Singleton.error("set_music_volume", "arg type has a typo")
	
	bg_music_volume_db = db
	bg_music_volume_p = percent
	
	bg_music_tracks[current_bg_music_track].volume_db = db

func get_sfx_volume(type:="percent"):
	match type:
		"percent":
			return sfx_volume_p
		"db":
			return sfx_volume_db
		_:
			Singleton.error("get_sfx_volume", "arg type has a typo")

func set_sfx_volume(volume:float, type:="percent"):
	var db : float
	var percent : float
	
	match type:
		"percent":
			db = linear2db(volume)
			percent = volume
		"db":
			db = volume
			percent = db2linear(volume)
		_:
			Singleton.error("set_sfx_volume", "arg type has a typo")
	
	sfx_volume_db = db
	sfx_volume_p = percent
	
	sfx_tracks[current_sfx_track].volume_db = db
