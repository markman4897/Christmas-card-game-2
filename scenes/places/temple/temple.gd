class_name Temple
extends BasePlace


#
# SIGNAL HANDLING
#

func _prison_door_trigger(_body):
	S.change_scene("temple_prison", "door")

func _enterance_door_trigger(_body):
	S.change_scene("temple_enterance", "door")

# ensures the night animation goes after transition animation
func _on_bg_animation_finished() -> void:
	if $background/bg.animation == "transition":
		$background/bg.animation = "night"


#
# OTHER FUNCS
#

func loop_santa_sleigh():
	$background/santa_sleigh.visible = false
	yield(get_tree().create_timer(3), "timeout")
	$background/santa_sleigh.frame = 0
	$background/santa_sleigh.visible = true
