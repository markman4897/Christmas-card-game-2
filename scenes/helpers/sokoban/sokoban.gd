extends Node2D

# mouse or keyboard, same as the overworld
# keyboard > accept or mouse on player = restart room

# can't go through collisions
# can push multiple boxes
# can't pull boxes

enum Directions {down, left, up, right}

const Direction_vec = {
	"up": Vector2(0,-1),
	"down": Vector2(0,1),
	"left": Vector2(-1,0),
	"right": Vector2(1,0),
	}
const PRESENT = 0
const TARGET = 5
const PLAYER = 1

const DOOR = 2

var player_pos : Vector2
var door_pos : Array
var target_pos : Array

var input := true


func _ready():
	# get player position in objects tilemap
	player_pos = $objects.get_used_cells_by_id(PLAYER)[0]
	
	# get door position in room tilemap
	var actual_door_tile = $room.get_used_cells_by_id(DOOR)[0]
	door_pos = [actual_door_tile+Vector2(0,1), actual_door_tile+Vector2(1,1)]
	
	# get target positions
	target_pos = $room.get_used_cells_by_id(TARGET)

func _unhandled_input(event) -> void:
	if input and event.is_pressed():
		if event.is_action("ui_up"):
			try_move("up")
		
		elif event.is_action("ui_down"):
			try_move("down")
		
		elif event.is_action("ui_left"):
			try_move("left")
		
		elif event.is_action("ui_right"):
			try_move("right")
		
		elif event.is_action("ui_accept"):
			restart_level()
		
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.is_pressed():
				var diff = get_viewport().get_mouse_position() - ($objects.map_to_world(player_pos) + Vector2(6,6))
				if diff.length() < 10:
					restart_level()
				
				else:
					if abs(diff.x) > abs(diff.y):
						if diff.x > 0:
							try_move("right")
						
						else:
							try_move("left")
						
					else:
						if diff.y > 0:
							try_move("down")
						
						else:
							try_move("up")
		
		if check_win_state():
			SS.save.locations_state.sokoban += 1
			SS.save.locations_state.bauble_borough = 1
			SS.save.progression.bauble_borough = 1
			S.change_scene("bauble_borough")

func try_move(direction):
	var next_tile = player_pos + Direction_vec[direction]
	
	if is_door(next_tile):
		S.change_scene("bauble_borough")
	
	elif is_wall(next_tile):
		pass
	
	elif is_present(next_tile):
		if check_move_present(next_tile, direction):
			move_present(next_tile, direction)
			move_player(next_tile, direction)
	
	else:
		move_player(next_tile, direction)

func is_door(vec:Vector2) -> bool:
	if vec == door_pos[0] or vec == door_pos[1]:
		return true
	
	return false

func is_wall(vec:Vector2) -> bool:
	var tmp = $room.get_cellv(vec)
	
	# HACK: do this with collision checking somehow
	#if $room.get_collision_layer_bit($room.get_cellv(vec)):
	if (tmp != 3 and tmp != 5) and tmp > -1:
		return true
	
	return false

func is_present(vec:Vector2) -> bool:
	if $objects.get_cellv(vec) == PRESENT:
		return true
	
	return false

func move_player(vec:Vector2, direction:String) -> void:
	# delete current player
	$objects.set_cellv(player_pos, -1)
	
	# make new one
	$objects.set_cell(vec.x, vec.y, PLAYER, false, false, false, Vector2(Directions[direction],0))
	player_pos = vec

func check_move_present(tile:Vector2, direction:String) -> bool:
	var next_tile = tile + Direction_vec[direction]
	
	if is_wall(next_tile) or is_present(next_tile):
		return false
	
	return true

func move_present(vec:Vector2, direction:String):
	$objects.set_cellv(vec, -1)
	
	$objects.set_cellv(vec + Direction_vec[direction], PRESENT)

func restart_level() -> void:
	S.change_scene("sokoban", false)

func check_win_state() -> bool:
	for target in target_pos:
		if $objects.get_cellv(target) != PRESENT:
			return false
	
	return true
