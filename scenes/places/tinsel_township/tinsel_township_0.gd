extends TinselTownship


var elf_text := {
	"start": {
		"type": "response",
		"text": "oy! ye there! the elf with the funny looking face, c'mere will ya?",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "i need ye aid ta settle some matters of the christmas variety, likesay. see that terrible elf over there?",
		"next": "2"
	},
	"2": {
		"type": "question",
		"text": "well, watch out for him!",
		"options": [
			{
				"text": "why?",
				"next": "3"
			},
			{
				"text": "what kind of face?!",
				"next": "3"
			},
			{
				"text": "i need the town key!",
				"next": "3"
			}
		]
	},
	"3": {
		"type": "response",
		"text": "what say we strike up a deal of sorts. see, gift giving round these parts is important and in a pinch i",
		"next": "4"
	},
	"4": {
		"type": "response",
		"text": "offered that piece of work my prised chicken for christmas. now, i ain't ready to go without eggs for",
		"next": "5"
	},
	"5": {
		"type": "response",
		"text": "breakfast, but the prat won't accept other gifts. i need ye to put that noodle of yours to use and trick",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "the elf into accepting this dog and corn instead.",
		"return": "none"
	},
}

var elf2_text := {
	"start": {
		"type": "response",
		"text": "the mayor warned you about me, didn't he!",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "well, don't listen to that old goof, he gave me the chicken and he can't have it back.",
		"options": [
			{
				"text": "interested in some corn?",
				"next": "end"
			},
			{
				"text": "how about a dog though?",
				"next": "end"
			},
			{
				"text": "just think about his it",
				"next": "end"
			}
		]
	},
	"end": {
		"type": "response",
		"text": "alright, fine... i'll give him his prized chicken back, but i want two gifts in return",
		"return": "stage_1"
	},
}

var elf_text_2 := {
	"start": {
		"type": "response",
		"text": "i was spyin' ... so he agreed right? you made him take the offer, nicely done.",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "now, what do you want to take first? the dog or the corn? what will it be, huh?",
		"options": [
			{
				"text": "the dog first, definitely",
				"next": "dog"
			},
			{
				"text": "has to be the corn",
				"next": "corn"
			}
		]
	},
	"dog": {
		"type": "response",
		"text": "alright, here's my precious dog... he was in our family for 8 years... but my breakfast eggs come first",
		"return": "stage_2_dog"
	},
	"corn": {
		"type": "response",
		"text": "alright, here's my precious corn, first cob of this years harvest. they say it brings the owner luck",
		"return": "stage_2_corn"
	},
}

var elf2_text_3_corn := {
	"start": {
		"type": "response",
		"text": "oh great, a freshly dried corn cob. and its oddly nice lookin' too... i wonder where he's been hiding this beaut",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "alright, back to business, so how do we do this, you wanna take the chicken or the cob back?",
		"options": [
			{
				"text": "cob goes back",
				"next": "loopback"
			},
			{
				"text": "give me the chicken",
				"next": "end"
			}
		]
	},
	"loopback": {
		"type": "response",
		"text": "i don't think that's the right call there buddy, and i really like the cob. wanna rethink that choice?",
		"next": "1"
	},
	"end": {
		"type": "response",
		"text": "alright then, off ye go with the chicken, but you better get me that dog ya hear!",
		"return": "stage_3_corn"
	},
}

var elf2_text_3_dog := {
	"start": {
		"type": "response",
		"text": "whoa, he seriously gave me his family dog? what will the kids and his wife say about this...",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "well, he made his choice, now you make yours. what will you take, the dog back or this chicken?",
		"options": [
			{
				"text": "it's his dog...",
				"next": "loopback"
			},
			{
				"text": "give the chicken",
				"next": "end"
			}
		]
	},
	"loopback": {
		"type": "response",
		"text": "i mean i agree, but if you take the dog back the deal is off. wanna rethink that choice?",
		"next": "1"
	},
	"end": {
		"type": "response",
		"text": "not gonna lie, that deal with the dog was harsh, but such is the thing we call business",
		"return": "stage_3_dog"
	},
}

var elf_text_4_corn := {
	"start": {
		"type": "response",
		"text": "my precious darling chicken! if i'm honest i didn't think you could pull this off, but you did!",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "okay, the last thing to do is to give him ol' buster. or do you think you should take the chicken back?",
		"options": [
			{
				"text": "lets return the hen",
				"next": "loopback"
			},
			{
				"text": "the dog must go",
				"next": "end"
			}
		]
	},
	"loopback": {
		"type": "response",
		"text": "but i just can't. i'll really miss the pupper, but i can't have an empty plate in the morning, ya know",
		"next": "1"
	},
	"end": {
		"type": "response",
		"text": "buddy pal... go with this nice elf, he'll take you to a new home... treat him nice will ya?",
		"return": "stage_4"
	},
}

var elf_text_4_dog := {
	"start": {
		"type": "response",
		"text": "my precious darling chicken! if i'm honest i didn't think you could pull this off, but you did!",
		"next": "1"
	},
	"1": {
		"type": "question",
		"text": "alright, the cob is his, but it did bring me luck when i was trapped under ice, so what will it be?",
		"options": [
			{
				"text": "give me the chicken",
				"next": "loopback"
			},
			{
				"text": "the cob must go",
				"next": "end"
			}
		]
	},
	"loopback": {
		"type": "response",
		"text": "but i just can't. i'll survive without the cob, but i can't have an empty plate in the morning, ya know",
		"next": "1"
	},
	"end": {
		"type": "response",
		"text": "so long shiny cob, it was fun while it lasted, but it's better he has you than to be tomorrows breakfast",
		"return": "stage_4"
	},
}

var elf2_text_5 := {
	"start": {
		"type": "response",
		"text": "alright, that's all, deal's done, business made, transaction complete, gifts gifted, no more takebacks!",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "oh man... i just realised i got no dog food. do you have any? nevermind, you've done enough already.",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "well, i guess you better go tell the mayor that the deal is done.",
		"return": "stage_5"
	},
}

var elf_text_done := {
	"start": {
		"type": "response",
		"text": "congrats on the deal, buddy. we couldn't have done it without ya.",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "but still, i'm not sure how to feel about this, the kids cried a little and my wife won't speak to me",
		"next": "2"
	},
	"2": {
		"type": "response",
		"text": "but at least they don't complain in the morning while we're all eating breakfast eggs",
		"next": "3"
	},
	"3": {
		"type": "response",
		"text": "anyway, since you asked before, i found this key a few days ago and you can have it as a thanks for",
		"next": "end",
	},
	"end": {
		"type": "response",
		"text": "helping me. merry christmas",
		"return": "key"
	},
}

var elf2_text_done := {
	"start": {
		"type": "response",
		"text": "i don't know how you pulled it off, i just wanted to have some fun with the mayor",
		"next": "1"
	},
	"1": {
		"type": "response",
		"text": "but this was too much... i didn't even want that chicken, it smells bad. i think i'm just gonna",
		"next": "end"
	},
	"end": {
		"type": "response",
		"text": "return things to the mayor a bit later. oh! but i'll need to bring an appology gift with me.",
		"return": "none"
	},
}


func _ready():
	# set up elves
	$objects/static/elf.connect_trigger(self, "_elf_trigger")
	$objects/static/elf2.connect_trigger(self, "_elf2_trigger")
	
	# load music
	AC.play_bg_music("sad")


#
# SIGNAL HANDLING
#

func _elf_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf_text, "_after_elf_text")

func _elf2_trigger(_a, _b, _c, _d) -> void:
	S.summon_textBox(self, elf2_text, "_after_elf2_text")


#
# OTHER FUNCS
#

# TODO: add selective blocking of interaction so you can only interact with the one necessarry

func _after_elf_text(arg):
	if arg == "stage_2_dog": 
		elf2_text = elf2_text_3_dog
	elif arg == "stage_2_corn":
		elf2_text = elf2_text_3_corn
	elif arg == "stage_4":
		elf2_text = elf2_text_5
	elif arg == "key":
		SS.save.locations_state.tinsel_township = 1
		SS.save.progression.tinsel_township = 1

func _after_elf2_text(arg):
	if arg == "stage_1": 
		elf_text = elf_text_2
	elif arg == "stage_3_corn":
		elf_text = elf_text_4_corn
	elif arg == "stage_3_dog":
		elf_text = elf_text_4_dog
	elif arg == "stage_5":
		elf_text = elf_text_done
		elf2_text = elf2_text_done
		AC.play_bg_music("happy")
