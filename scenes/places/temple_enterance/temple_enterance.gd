class_name TempleEnterance
extends BasePlace


#
# SIGNAL HANDLING
#

func _door_trigger(_body: Node) -> void:
	S.change_scene("temple", "enterance_door")

func _back_enterance_trigger(_body: Node) -> void:
	S.change_scene("temple_prison", "secret_enterance")

func _overworld_trigger(_body: Node) -> void:
	S.change_scene("overworld", "temple")

func _on_bg_animation_finished() -> void:
	if $background/bg.animation == "opening":
		$background/bg.animation = "opened"
