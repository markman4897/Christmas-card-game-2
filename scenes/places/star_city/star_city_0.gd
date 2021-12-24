extends StarCity


var elf_text = {
	"start": {
		"type": "response",
		"text": "okay, everyone, pack it up! christmas is cancelled. and if you don’t hurry, i’m taking new year’s too!",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "i can do that, you know. i’m the mayor... also the owner of star sandwiches, 'taste the difference', trademark...",
		"options": [
			{
				"text": "what’s going on?",
				"next": "2"
			},
			{
				"text": "hey, you can't do that",
				"next": "end-failure"
			}
		]
	},
	"2": {
		"type": "response",
		"text": "listen, it’s just not working out. all the gifts, the planning. we’re just gonna do halloween this year.",
		"next": "3"
	},
	"3": {
		"type": "response",
		"text": "if anyone really wants to give presents, you can come to tobin’s birthday next week. there’s gonna be a",
		"next": "4"
	},
	"4": {
		"type": "question",
		"text": "bouncy house, star sandwiches' pizza, the whole shabbang.",
		"options": [
			{
				"text": "it's not just about gifts",
				"next": "5"
			},
			{
				"text": "who's tobin?",
				"next": "5"
			},
			{
				"text": "you're a mean one, mayor",
				"next": "end-failure"
			}
		]
	},
	"5": {
		"type": "response",
		"text": "kid, i can tell you have some weird obsession with christmas, but i don't. you wanna know what i'm obsessed",
		"next": "6"
	},
	"6": {
		"type": "response",
		"text": "with? going down to star sandwiches, 'taste the difference', and getting one of our new limited-time-only",
		"next": "7"
	},
	"7": {
		"type": "question",
		"text": "loaded yule yams, trademark.",
		"options": [
			{
				"text": "wait, are you lonely?",
				"next": "8"
			},
			{
				"text": "your yams do taste great",
				"next": "8"
			},
			{
				"text": "who hurt you?",
				"next": "end-failure"
			}
		]
	},
	"8": {
		"type": "response",
		"text": "you make some good points, kid. but it doesn't work like that, i don't have anybody. i'm in my mid-40s, you think",
		"next": "9"
	},
	"9": {
		"type": "question",
		"text": "i can just make friends like that?",
		"options": [
			{
				"text": "that's really depressing",
				"next": "end-failure"
			},
			{
				"text": "get away from me...",
				"next": "end-failure"
			},
			{
				"text": "i thought we were friends",
				"next": "end-success"
			}
		]
	},
	"end-success": {
		"type": "response",
		"text": "well, alright, kid. hey, santiago, trundle, come back with that damn tree! christmas is un-cancelled!",
		"next": "success"
	},
	"success": {
		"type": "response",
		"text": "oh, right. the key. you can have it, i wasn’t using it for anything anyway.",
		"return": "success"
	},
	"end-failure": {
		"type": "response",
		"text": "you’re annoying me, give me that gift certificate, you’re not welcome at star sandwiches anymore!",
		"next": "failure"
	},
	"failure": {
		"type": "response",
		"text": " hey! this is expired!",
		"return": "failure"
	},
}

var elf2_text = {
	"start": {
		"type": "response",
		"text": "brrrr... so cold.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "i can't believe they actually kicked me out because i was just one day late on rent!",
		"return": "none"
	}
}

var elf3_text = {
	"start": {
		"type": "response",
		"text": "two loaded yule yams, extra large please",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "what do you mean this gift certificate is fake?! i spent a whole day moving boxes for this lousy cupon!!!",
		"return": "none"
	}
}


func _ready():
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	$objects/static/elf3.connect_trigger(self, "_elf3_trigger")
	
	# load music
	AC.play_bg_music("sad")
	
	yield(get_tree().create_timer(0.5), "timeout")
	$objects/static/elf.disable_collisions_when_moving = true
	$objects/static/elf.connect_end_move(self, "_after_move")
	$objects/static/elf.move_to(Vector2(76,96))


#
# SIGNAL HANDLING
#

# should be renamed to _red_trigger or something
func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_text")

# should be renamed to _red_trigger or something
func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf2_text)

# should be renamed to _red_trigger or something
func _elf3_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf3_text)


#
# OTHER FUNCS
#

func _after_move():
	$objects/static/elf.disable_collisions_when_moving = false
	S.summon_textBox(self, elf_text, "_after_text")

func _after_text(arg):
	if arg == "success":
		print("success")
