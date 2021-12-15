extends AnimationPlayer

signal done

func _ready():
	$curtain.visible = false
	Singleton.player_movement_disabled = true

func run(direction):
	if direction == "close":
		set_current_animation("down")
		$curtain.visible = true
	elif direction == "open":
		set_current_animation("up")
		$curtain.visible = true
	else:
		Singleton.error("summon_curtain", "wrong argument passed")

func _on_curtain_animation_finished(anim_name):
	emit_signal("done")
	
	Singleton.player_movement_disabled = false
	
	if anim_name == "up":
		self.queue_free()
