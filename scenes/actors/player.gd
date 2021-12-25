extends Npc

# adds player controlled movement


const control_deadzone := 2

const FIRST_COLOR = Color("d95763")
const SECOND_COLOR = Color("ac3232")


func _init():
	load_shader_replace_color(FIRST_COLOR,
			Color("99e550"),
			SECOND_COLOR,
			Color("6abe30"))


func _get_motion():
	# keyboard input
	var motion = Vector2(0,0)
	
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# touch/mouse input
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# get mouse pos
		var res = get_viewport().get_mouse_position() - self.position
		
		if abs(res.x) > control_deadzone or abs(res.y) > control_deadzone:
			motion = res
			# so that left/right animations don't get ignored
			if abs(motion.y) < control_deadzone: motion.y = 0
	
	motion = motion.normalized() * speed
	
	return motion
