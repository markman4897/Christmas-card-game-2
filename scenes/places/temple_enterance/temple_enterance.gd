class_name TempleEnterance
extends BasePlace


#
# MAIN FUNCS
#

func _ready() -> void:
	# just in case I fuck something up in the editor...
	$logic/portals/door_trigger.monitoring = false
	$logic/portals/back_enterance_trigger.monitoring = false


#
# SIGNAL HANDLING
#

func _door_trigger(_body: Node) -> void:
	S.change_scene("temple")

func _back_enterance_trigger(_body: Node):
	S.change_scene("temple_prison")

func _on_bg_animation_finished() -> void:
	if $background/bg.animation == "opening":
		$background/bg.animation = "opened"
