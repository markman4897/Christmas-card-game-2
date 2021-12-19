class_name Actor
extends KinematicBody2D


export var speed = Vector2(35,25)

var movement_disabled := false

var sprites : Dictionary
var sprite : String
var idle_animation : String


export var sprite_exported : String
export var idle_animation_exported : String

export var shader_replace_color = {
	"enabled" : false,
	"first_original" : Color.black,
	"first_replacement" : Color.black,
	"second_original" : Color.black,
	"second_replacement" : Color.black,
	}


func _ready():
	# set if exported variables are present
	if sprite_exported != "": sprite = sprite_exported
	if idle_animation_exported != "": idle_animation = idle_animation_exported
	
	# set if variables are present
	if sprite != "":
		$sprite.frames = sprites[sprite]
	if idle_animation != "":
		set_idle_animation(idle_animation)
	
	# set shader if set up in exported variables
	# TODO: figure out how to do this so you can also replace black color
	if shader_replace_color.enabled:
			# load in the shader
			$sprite.material = preload("res://assets/shaders/color_and_shade_replacement.tres")
			
			# set shader_params so it works
			# TODO: maybe add a check to see if they're all initialised somewhere?
			$sprite.material.set_shader_param("first", shader_replace_color.first_original)
			$sprite.material.set_shader_param("first_sub", shader_replace_color.first_replacement)
			$sprite.material.set_shader_param("second", shader_replace_color.second_original)
			$sprite.material.set_shader_param("second_sub", shader_replace_color.second_replacement)

func _physics_process(delta: float) -> void:
	var motion = Vector2(0,0)
	if !movement_disabled:
		motion = _get_motion()
		var _void = move_and_collide(motion * delta)
	_do_animations(motion)

func _get_motion():
	# just a placeholder for the actual function
	return Vector2(0,0)

#func _process(_delta: float) -> void:
#	self.set_z_index(int(self.position.y))


#
# Functions to be used from outside
#

func set_idle_animation(animation:String):
	# FIXME: there really should be some form of protection so you catch a typo of animation argument
	idle_animation = animation
	$sprite.animation = animation


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
