extends Node2D


var first_track = "res://assets/music/songs/MerryXmas.ogg"
var second_track = "res://assets/music/songs/Jingle.ogg"
var chat = "res://assets/music/sfx/chat.ogg"
var door_creek = "res://assets/music/sfx/door_creek.ogg"
var present_open = "res://assets/music/sfx/present_open.ogg"

func play_bg_music(track:AudioStream):
	$bg_music.stream = track
	$bg_music.play()
	
func play_sfx(track:AudioStream):
	$sfx.stream = track
	$sfx.play()
