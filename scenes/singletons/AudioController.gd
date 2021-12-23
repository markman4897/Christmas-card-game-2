extends Node


var bg_music_dict := {
	"sad": preload("res://assets/music/songs/MerryXmas.ogg"),
	"happy": preload("res://assets/music/songs/Jingle.ogg")
}

var ambiance_dict := {
	
}

var sfx_dict := {
	"voice": preload("res://assets/music/sfx/chat.ogg"),
	"door creek": preload("res://assets/music/sfx/door_creek.ogg"),
	"present open": preload("res://assets/music/sfx/present_open.ogg")
}


onready var bg_music_tracks := $bg_music.get_children()
var current_bg_music_track := 0

var bg_music_volume_db := 0.0
var bg_music_volume_p := 1.0

const bg_music_transition_time := 2.0


onready var ambiance_tracks := $ambiance.get_children()
var current_ambiance_track := 0

var ambiance_volume_db := 0.0
var ambiance_volume_p := 1.0

const ambiance_transition_time := 0.8


onready var sfx_tracks := $sfx.get_children()
var current_sfx_track := 0

var sfx_volume_db := 0.0
var sfx_volume_p := 1.0


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
	bg_music_tracks[next_track].stream = bg_music_dict[song]
	
	# play it
	bg_music_tracks[next_track].play()
	# fade old one out
	S.summon_tween(bg_music_tracks[current_bg_music_track], "volume_db", bg_music_volume_db,
			-80.0, bg_music_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_IN)
	# fade new one in
	S.summon_tween(bg_music_tracks[next_track], "volume_db", -80.0, bg_music_volume_db,
			 bg_music_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_OUT)
	current_bg_music_track = next_track

func play_ambiance(song:String):
	# get next track
	var next_track = get_next(ambiance_tracks, current_ambiance_track)
	
	# set it up
	# FIXME: move this so it stopps after fade out
	ambiance_tracks[next_track].stop()
	ambiance_tracks[next_track].volume_db = -80.0
	ambiance_tracks[next_track].stream = ambiance_dict[song]
	
	# play it
	ambiance_tracks[next_track].play()
	# fade old one out
	S.summon_tween(ambiance_tracks[current_ambiance_track], "volume_db", ambiance_volume_db,
			-80.0, ambiance_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_IN)
	# fade new one in
	S.summon_tween(ambiance_tracks[next_track], "volume_db", -80.0, ambiance_volume_db,
			 ambiance_transition_time, "none", Tween.TRANS_QUART, Tween.EASE_OUT)
	current_ambiance_track = next_track

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
			S.error("get_music_volume", "arg type has a typo")

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
			S.error("set_music_volume", "arg type has a typo")
	
	bg_music_volume_db = db
	bg_music_volume_p = percent
	
	SS.save.music_volume = percent
	
	bg_music_tracks[current_bg_music_track].volume_db = db

func get_ambiance_volume(type:="percent"):
	match type:
		"percent":
			return ambiance_volume_p
		"db":
			return ambiance_volume_db
		_:
			S.error("get_ambiance_volume", "arg type has a typo")

func set_ambiance_volume(volume:float, type:="percent"):
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
			S.error("set_music_volume", "arg type has a typo")
	
	ambiance_volume_db = db
	ambiance_volume_p = percent
	
	SS.save.ambiance_volume = percent
	
	ambiance_tracks[current_ambiance_track].volume_db = db

func get_sfx_volume(type:="percent"):
	match type:
		"percent":
			return sfx_volume_p
		"db":
			return sfx_volume_db
		_:
			S.error("get_sfx_volume", "arg type has a typo")

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
			S.error("set_sfx_volume", "arg type has a typo")
	
	sfx_volume_db = db
	sfx_volume_p = percent
	
	SS.save.sfx_volume = percent
	
	sfx_tracks[current_sfx_track].volume_db = db
