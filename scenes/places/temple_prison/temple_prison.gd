class_name TemplePrison
extends BasePlace


#
# SIGNAL HANDLING
#

func _door_trigger(_body: Node) -> void:
	S.change_scene("temple")

func _back_enterance_trigger(_body: Node):
	S.change_scene("temple_enterance")

func _on_bg_animation_finished() -> void:
	if $background/bg.animation == "opening":
		$background/bg.animation = "opened"
