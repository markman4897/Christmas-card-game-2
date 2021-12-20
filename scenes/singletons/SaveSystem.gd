extends Node


const SAVE_FILE_LOCATION = "user://conf.json"
# also doubles as list of all settings
var settings_default := {
	"music_volume" : 0.5,
	"sfx_volume" : 0.6,
}
var settings : Dictionary


# import settings from file, if it doesn't exist, create one
func _init():
	if !file_to_settings():
		create_settings_file()


#
# Functions
#

func settings_to_file() -> void:
	var save_file = File.new()
	save_file.open(SAVE_FILE_LOCATION, File.WRITE)
	save_file.store_string(to_json(settings))
	save_file.close()

func file_to_settings() -> bool:
	var save_file = File.new()
	if save_file.file_exists(SAVE_FILE_LOCATION):
		save_file.open(SAVE_FILE_LOCATION, File.READ)
		settings = parse_json(save_file.get_as_text())
		
		save_file.close()
		return true
	
	save_file.close()
	return false

func create_settings_file() -> void:
	var save_file = File.new()
	if !save_file.file_exists(SAVE_FILE_LOCATION):
		save_file.open(SAVE_FILE_LOCATION, File.WRITE)
		save_file.store_string(to_json(settings_default))
	
	save_file.close()

func delete_settings_file() -> void:
	var dir = Directory.new()
	if dir.file_exists(SAVE_FILE_LOCATION):
		dir.remove(SAVE_FILE_LOCATION)


#
# Handling quitting the game
#

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST
		or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
			print("save sys")
			# save settings before quitting just in case
			SS.settings_to_file()
