class_name Actor
extends KinematicBody2D

# handles animation and sets up movement


export var speed = Vector2(35,25)

var movement_disabled := false

var sprites : Dictionary
var sprite : String
var idle_animation : String


export var is_actor := false
export var sprite_exported : String
export var idle_animation_exported : String


func _ready():
	# set if exported variables are present
	if sprite_exported != "": sprite = sprite_exported
	if idle_animation_exported != "": idle_animation = idle_animation_exported
	
	# set if variables are present
	if sprite != "":
		$sprite.frames = sprites[sprite]
	if idle_animation != "":
		set_idle_animation(idle_animation)

func _physics_process(delta: float) -> void:
	if !is_actor:
		var motion = Vector2(0,0)
		if !movement_disabled:
			motion = _get_motion()
			var _void = move_and_collide(motion * delta)
		_do_animations(motion)

func _get_motion():
	# just a placeholder for the actual function
	return Vector2(0,0)


#
# Functions to be used from outside
#

func set_idle_animation(animation:String):
	# FIXME: there really should be some form of protection so you catch a typo of animation argument
	idle_animation = animation
	$sprite.animation = animation

func set_animation(animation:String):
	$sprite.animation = animation

func toggle_movement(state:bool):
	movement_disabled = state


#
# Functions
#

func _do_animations(motion):
	# trigger animations based on movement
	match [motion.x != 0, motion.y != 0]:
		[false,true],[true,true]:
			if motion.y > 0:
				if $sprite.animation != "run_down":
					$sprite.animation = "run_down"
			else:
				if $sprite.animation != "run_up":
					$sprite.animation = "run_up"
		[true,false]:
			if motion.x > 0:
				if $sprite.animation != "run_right":
					$sprite.animation = "run_right"
			else:
				if $sprite.animation != "run_left":
					$sprite.animation = "run_left"
		[false,false]:
			if $sprite.animation != idle_animation:
				$sprite.animation = idle_animation

func load_shader_replace_color(first:Color, first_sub:Color, second:Color, second_sub:Color):
	# load in a copy of the shader
	$sprite.material = preload("res://assets/shaders/color_and_shade_replacement.tres").duplicate()
	
	# set shader_params so it works
	# TODO: maybe add a check to see if they're all initialised before execution?
	$sprite.material.set_shader_param("first", first)
	$sprite.material.set_shader_param("first_sub", first_sub)
	$sprite.material.set_shader_param("second", second)
	$sprite.material.set_shader_param("second_sub", second_sub)
