extends Tween

signal done

func _on_Tween_tween_all_completed():
	emit_signal("done")
	queue_free()
