extends Npc

# adds shader for changing color and exports enum for ease of use


const FIRST_COLOR = Color("d95763")
const SECOND_COLOR = Color("ac3232")

enum ELVES {bauble,star,tinsel}
export(ELVES) var elf_type := ELVES.bauble
const shader_values = [
	[Color("d95763"),Color("ac3232")],
	[Color("639bff"),Color("306082")],
	[Color("696a6a"),Color("595652")],
]


func _ready():
	# set shader color replacement values
	if elf_type > 0: # because 0 is red, like the original resource
		load_shader_replace_color(FIRST_COLOR,
				shader_values[elf_type][0],
				SECOND_COLOR,
				shader_values[elf_type][1])
