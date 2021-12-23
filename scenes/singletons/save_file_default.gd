class_name SaveFileDefault
extends Resource

# TODO: write setget functions with limits and/or checkers for variables

# Default values for saved variables
export var music_volume := 0.5
export var sfx_volume := 0.6

export var locations_state := {
	"menu": 0,
	"overworld": 0,
	"temple_enterance": 0,
	"temple": 0,
	"temple_prison": 0,
	"star_city": 0,
	"tinsel_town": 0,
	"bauble_borough": 0,
}

export var last_location := "temple_enterance"
