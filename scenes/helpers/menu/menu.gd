extends Control


const locations := [Vector2(0,0),Vector2(-128,0),Vector2(-256,0)]
var location = 1

func _ready():
	# set current values for sound sliders
	$container/settings/fields/music/HSlider.value = AC.get_music_volume()
	$container/settings/fields/sfx/HSlider.value = AC.get_sfx_volume()
	
	# load music
	AC.play_bg_music("happy") # TODO: change this to something new
	
	$container/menu/buttons/start.grab_focus()


#
# Signals
#

func _on_start_pressed():
	S.change_scene(SS.save.last_location)

func _slide_screen(new_location):
	if new_location < 0 or new_location > 2:
		S.error("_slide_screen", "out of bounds")
		return
	
	location = new_location
	
	$tween.remove_all()
	$tween.interpolate_property($container, "rect_position",
		$container.rect_position, locations[location], 0.8,
		Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$tween.start()
	
	match location:
		0:
			$container/about/fields/back.grab_focus()
		1:
			$container/menu/buttons/start.grab_focus()
		2:
			$container/settings/fields/music/HSlider.grab_focus()

func _music_changed(value):
	AC.set_music_volume(value)

func _ambiance_changed(value):
	AC.set_ambiance_volume(value)

func _sfx_changed(value):
	AC.set_sfx_volume(value)


func _on_clear_save_pressed():
	SS.clear_settings_file()
