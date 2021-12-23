class_name Npc
extends Actor

# adds guided movement


signal path_completed
signal destination_reached


onready var destination := Vector2(self.position.x, self.position.y)
var moving := false
var disable_collisions_when_moving := false


func _ready():
	var _void = connect("destination_reached", self, "_dest_reached")


#
# Signals
#

# only used for when "disable_collisions_when_moving" is true
func _dest_reached():
	$body.set_deferred("disabled", false)


#
# Functions to be used from outside
#

func connect_trigger(node:Node, func_name:String):
	var _void = $sensor.connect("area_shape_entered", node, func_name)

func connect_end_move(node:Node, func_name:String):
	var _void = self.connect("destination_reached", node, func_name)

func connect_end_path(node:Node, func_name:String):
	var _void = self.connect("path_completed", node, func_name)

func move_to(coords:Vector2):
	if disable_collisions_when_moving:
		$body.set_deferred("disabled", true)
	
	destination = coords

func move_path(path:Array):
	for i in path:
		move_to(i)
		yield(self, "destination_reached")
		if disable_collisions_when_moving:
			$body.set_deferred("disabled", false)
	
	emit_signal("path_completed")

func set_sprite(spr:String):
	sprite = spr
	$sprite.frames = sprites[sprite]


#
# Other functions
#

func _get_motion():
	var motion = (destination - self.position).round()
	
	if motion == Vector2(0,0):
		if moving:
			emit_signal("destination_reached")
		moving = false
	else:
		moving = true
	
	motion = motion.normalized()
	motion *= speed
	
	return motion
