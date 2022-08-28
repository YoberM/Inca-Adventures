extends Node


# Settings avaliable
enum Settings {
	GRAPHICS,
	AUDIO,
	CONTROLS,
	LANGUAGE,
	RESOLUTION,
	WINDOW_MODE,
	VSYNC,
	FULLSCREEN,
	WINDOW,
	BORDERLESS,
}

# Settings Options
var resolutions: Dictionary = {
	"1920x1080" : Vector2(1920,1080),
	"1600x900" : Vector2(1600,900),
	"1024x600" : Vector2(1024,600),
}

var window_modes: Dictionary = {
	"FullScreen" : Settings.FULLSCREEN,
	"Window" : Settings.WINDOW,
	"Window Borderless" : Settings.BORDERLESS,
}

var vsync: Dictionary = {
	"On" : true,
	"Off" : false,
}

# Default Settings
var parameters: Dictionary = {
	"GRAPHICS" : {
		"WINDOW_MODE" : "Window",
		"RESOLUTION" : "1024x600",
		"VSYNC" : "On",
	}
}

var _settings_dir = "user://config/settings.cfg"
var _default_conf = ConfigFile.new()
var _current_conf = ConfigFile.new()
var _load_status: int = OK


func _init() -> void:
	_init_default_conf()
	load_settings()


func load_settings() -> void:
	if (not _path_exist()):
		_create_path()
	_current_conf.load(_settings_dir)
	for section in _default_conf.get_sections():
		for key in _default_conf.get_section_keys(section):
			if (_current_conf.has_section_key(section,key)):
				continue
			var value = _default_conf.get_value(section,key)
			_current_conf.set_value(section,key,value)


func set_setting(setting_section: int,setting_key: int,value: String) -> void:
	var section: String = _get_name(setting_section)
	var key: String = _get_name(setting_key)
	if (_setting_exists(section,key)):
		_current_conf.set_value(section,key,value)


func discard_configuration() -> void:
	load_settings()


func save_settings() -> int:
	var save_status: int = _current_conf.save(_settings_dir)
	if ( save_status == OK):
		_apply_settings()
	return save_status


func get_setting(section: int,key: int) -> String:
	var section_name: String = _get_name(section)
	var key_name: String = _get_name(key)
	if (_setting_exists(section_name,key_name)):
		var value = _current_conf.get_value(section_name,key_name)
		return value
	return "THE SETTING DOESN'T EXIST"


func _init_default_conf() -> void:
	for section in parameters:
		for parameter in parameters[section]:
			var value = parameters[section][parameter]
			_default_conf.set_value(section,parameter,value)


func _apply_settings() -> void:
	var resolution: String = get_setting(Settings.GRAPHICS,Settings.RESOLUTION)
	var window_mode: String = get_setting(Settings.GRAPHICS,Settings.WINDOW_MODE)
	var vsync_value: String = get_setting(Settings.GRAPHICS,Settings.VSYNC)
	
	OS.window_size = resolutions[resolution]
	OS.window_borderless = true if window_modes[window_mode] == Settings.BORDERLESS else false
	OS.window_fullscreen = true if window_modes[window_mode] == Settings.FULLSCREEN else false
	OS.center_window()
	OS.vsync_enabled = vsync[vsync_value]


func _setting_exists(section: String,key: String) -> bool:
	return (parameters.has(section) && parameters[section].has(key))


func _get_name(idx: int) -> String:
	return Settings.keys()[idx]


func _path_exist() -> bool:
	var dir: Directory = Directory.new()
	return dir.dir_exists("user://config/")


func _create_path() -> void:
	var dir: Directory = Directory.new()
	var open_value = dir.open("user://")
	if open_value != OK:
		print_debug("Unable to open user folder")
	else:
		var config_value = dir.make_dir("config/")
		if config_value != OK:
			print_debug("Unable to create config folder")
