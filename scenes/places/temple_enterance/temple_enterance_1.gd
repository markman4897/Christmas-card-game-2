extends TempleEnterance


var text := {
	"start": {
		"type": "response",
		"text": "okay, sneaking hasn’t worked so i better get ready for a fight!",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "this time i won't be surprised by his migthy magic... although i do have a sightly bad feeling about it",
		"return": "none"
	},
}


func _ready():
	$logic/portals/back_enterance_trigger.monitoring = false
	yield(get_tree().create_timer(1.5), "timeout")
	S.summon_textBox(self, text)
