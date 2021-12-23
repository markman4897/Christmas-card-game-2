extends Node2D

# acts as the world map for traveling around


const snowed_in_text = {
	"start": {
		"type": "response",
		"text": "looks like the road is snowed in...",
		"return": "none"
	}
}


onready var current_point := $logic/points/hub

var input := true
var direction := "none"


func _ready() -> void:
	$objects/moving/player.position = current_point.position

func _process(delta) -> void:
	move_player(delta)

func _unhandled_input(event) -> void:
	if input:
		if event.is_action("ui_up"):
			direction = "up"
		elif event.is_action("ui_down"):
			direction = "down"
		elif event.is_action("ui_left"):
			direction = "left"
		elif event.is_action("ui_right"):
			direction = "right"
		elif event.is_action("ui_accept"):
			load_current_point()
		
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.is_pressed():
				var diff = get_viewport().get_mouse_position() - $objects/moving/player.position
				if diff.length() < 10:
					load_current_point()
				else:
					if abs(diff.x) > abs(diff.y):
						if diff.x > 0:
							direction = "right"
						else:
							direction = "left"
					else:
						if diff.y > 0:
							direction = "down"
						else:
							direction = "up"


func move_player(delta) -> void:
	if direction != "none":
		if current_point[direction] == 1:
			input = false
			S.summon_textBox(self, snowed_in_text, "after_text")
			direction = "none"
		
		elif current_point[direction] == 2:
			var path_follow = current_point.get_node(current_point[direction.left(1)+"_path"]).get_node("PathFollow2D")
			var path_direction = current_point[direction.left(1)+"_direction"]
			
			if input:
				if path_direction:
					path_follow.unit_offset = 0.0
				else:
					path_follow.unit_offset = 1.0
				
				input = false
			
			if !input:
				if path_direction:
					path_follow.offset += delta*20
				else:
					path_follow.offset -= delta*20
				
				if path_follow.unit_offset == 1 or path_follow.unit_offset == 0:
					current_point = current_point.get_node(current_point[direction.left(1)+"_destination"])
					input = true
					direction = "none"

func load_current_point() -> void:
	if current_point.place != "none":
		S.change_scene(current_point.place)

func after_text(_arg):
	# TODO: this is somewhat hacky, find a place to call this after the textbox
	#       is gone and the click is over
	yield(get_tree().create_timer(0.5), "timeout")
	input = true
