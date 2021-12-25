extends Temple


var big_bad_text := {
	"start": {
		"type": "response",
		"text": "i... have... been watching... you... elf... your christmas... spirit... has moved... the mighty krampus...",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "thank... you... for the... opportunity... to experience... the sensation... called... christmas... spirit...",
		"return": "none"
	}
}

var santa_text := {
	"start": {
		"type": "response",
		"text": "by golly, you just saved christmas! here’s a 20c gift certificate for yule tunes, i think it still has 8c on it.",
		"return": "first"
	},
}

var santa_text_2 := {
	"start": {
		"type": "response",
		"text": "hope that certificate is still valid... it's been an awful long since i used it last...",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "you know, because i was in prison",
		"return": "none"
	},
}


func _ready():
	$objects/moving/santa.connect_trigger(self, "_santa_trigger")
	$objects/moving/big_bad.connect_trigger(self, "_big_bad_trigger")
	
	# load music
	AC.play_bg_music("sad")
	
	SS.save.locations_state.temple_enterance = 2


#
# SIGNAL HANDLING
#

func _santa_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, santa_text, "_after_santa_text")

func _big_bad_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, big_bad_text, "_after_big_bad_text")


#
# OTHER FUNCS
#

func _after_santa_text(arg):
	if arg == "first":
		$background/bg.animation = "transition"
		santa_text = santa_text_2

func _after_big_bad_text(_arg):
	AC.play_bg_music("happy")
	SS.save.locations_state.temple = 2

