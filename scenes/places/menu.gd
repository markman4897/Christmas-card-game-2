extends Control


const locations := [Vector2(0,0),Vector2(-128,0),Vector2(-256,0)]
var location = 1

func _ready():
	# set current values for sound sliders
	$container/settings/fields/music/HSlider.value = AudioController.get_music_volume()
	$container/settings/fields/sfx/HSlider.value = AudioController.get_sfx_volume()
	
	# load music
	AudioController.play_bg_music("happy") # TODO: change this to something new
	
	$container/menu/buttons/start.grab_focus()


#
# Signals
#

func _on_start_pressed():
	Singleton.change_scene("enterance")

func _slide_screen(new_location):
	if new_location < 0 or new_location > 2:
		Singleton.error("_slide_screen", "out of bounds")
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

func _sfx_changed(value):
	AudioController.set_sfx_volume(value)

func _music_changed(value):
	AudioController.set_music_volume(value)
