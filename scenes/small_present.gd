extends Sprite


var interactable = true
var upper_node2D

func _ready() -> void:
	upper_node2D = get_parent().get_parent()

func _on_trigger_area_entered(area: Area2D) -> void:
	if interactable:
		# chimp blooper
		upper_node2D.chimp.append(self.frame)
		if upper_node2D.chimp == upper_node2D.chimp_code:
			upper_node2D.get_node("chimp").visible = true
		
		var sfx:AudioStream = load(AudioController.present_open)
		AudioController.play_sfx(sfx)
		self.frame += 4
		interactable = false
