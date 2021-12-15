extends KinematicBody2D

class_name Actor


export var speed = Vector2(35,25)


var movement_disabled := false

var sprites := {
	"b_elf": preload("res://assets/aseprite_files/npcs/elves/b_elf.aseprite")
}

export var sprite := "b_elf"

export var idle_animation := "idle"


func _ready():
	$sprite.frames = sprites[sprite]
	set_idle_animation(idle_animation)

func _physics_process(delta: float) -> void:
	var motion = Vector2(0,0)
	if !movement_disabled:
		motion = _get_motion()
		Singleton._void = move_and_collide(motion * delta)
	_do_animations(motion)

func _get_motion():
	# just a placeholder for the actual function
	return Vector2(0,0)

func _process(_delta: float) -> void:
	self.set_z_index(int(self.position.y))


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
