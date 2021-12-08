extends KinematicBody2D


# HACK: maybe move this to global? (for easier implementation in other scripts... idk...)
# so you can disable input
var disable_input = false
# make a custom signal? set it from outside scripts? idk man...

var speed = 40
var v_speed = 25

onready var animSprite = get_node("AnimatedSprite")

func _physics_process(delta: float) -> void:
	# disable movement on demand
	if disable_input:
		animSprite.animation = "idle"
		return
	
	# movement
	var motion = Vector2(0,0)
	motion.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))*speed
	motion.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))*v_speed
	
	# touch/mouse movement, yeh?
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# get mouse pos
		var mouse_pos = get_viewport().get_mouse_position()
		var elf_pos = self.position
		var res = mouse_pos - elf_pos
		# this is ugly...
		if res.x > 5:
			motion.x = speed
		elif res.x < -1:
			motion.x = -speed
		if res.y > 5:
			motion.y = v_speed
		elif res.y < -5:
			motion.y = -v_speed
	
	# TODO maybe use lerp here?
	# Variant lerp ( Variant from, Variant to, float weight )
	# https://godotengine.org/qa/65222/i-did-not-understand-well-lerp-function
	move_and_collide(motion * delta)
	
	# trigger animations based on movement
	match [motion.x != 0, motion.y != 0]:
		[false,true],[true,true]:
			if motion.y > 0:
				if animSprite.animation != "run_down":
					animSprite.animation = "run_down"
			else:
				if animSprite.animation != "run_up":
					animSprite.animation = "run_up"
		[true,false]:
			if motion.x > 0:
				if animSprite.animation != "run_right":
					animSprite.animation = "run_right"
			else:
				if animSprite.animation != "run_left":
					animSprite.animation = "run_left"
		[false,false]:
			if animSprite.animation != "idle":
				animSprite.animation = "idle"
