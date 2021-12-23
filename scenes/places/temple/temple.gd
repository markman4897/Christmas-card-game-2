class_name Temple
extends Node2D


#
# MAIN FUNCS
#

func _ready():
	# just in case I fuck something up in the editor...
	$logic/portals/prison_door.monitoring = false
	$logic/portals/enterance_door.monitoring = false
	$background/santa_sleigh.visible = false


#
# SIGNAL HANDLING
#

func _prison_door_trigger():
	S.change_scene("temple_prison")


func _enterance_door_trigger():
	S.change_scene("temple_enterance")

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
