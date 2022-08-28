extends Menu


export(NodePath) var window_label
export(NodePath) var resolution_label
export(NodePath) var vsync_label


func _ready():
	var window: Node = get_node(window_label)
	var resolution: Node = get_node(resolution_label)
	var vsync: Node = get_node(vsync_label)
	# letting the optiones to the nodes
	window.set_options(SM.window_modes.keys())
	resolution.set_options(SM.resolutions.keys())
	vsync.set_options(SM.vsync.keys())
	# mapping the nodes with their setting
	map_option(SM.Settings.WINDOW_MODE, window)
	map_option(SM.Settings.RESOLUTION, resolution)
	map_option(SM.Settings.VSYNC, vsync)
	# reading the current configuration
	var window_option = SM.get_setting(SM.Settings.GRAPHICS,SM.Settings.WINDOW_MODE)
	var resolution_option = SM.get_setting(SM.Settings.GRAPHICS,SM.Settings.RESOLUTION)
	var vsync_option = SM.get_setting(SM.Settings.GRAPHICS,SM.Settings.VSYNC)
	# loading the current configuration in the UI
	window.set_index(window.options.find(window_option))
	resolution.set_index(resolution.options.find(resolution_option))
	vsync.set_index(vsync.options.find(vsync_option))
	
	options_map[0]['display_node'].grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		for setting in options_map:
			if not setting['display_node'].has_focus():
				continue
			SM.set_setting(
				SM.Settings.GRAPHICS,
				setting['setting'],
				setting['display_node'].get_text()
			)
			SM.save_settings()


func _on_GraphicsMenu_visibility_changed():
	if self.visible:
		options_map[0]['display_node'].grab_focus()
