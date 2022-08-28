tool
extends EditorPlugin


const WPREFIX: String = "HCEditorPlugin: "

const WC001: String = "[WC001] Non-valid Component Source declaration"
const WC002: String = "[WC002] Non-valid Component Icon declaration"

const DUMMY_SCRIPT_RES: Resource = preload("res://addons/handy_components/Dummy.gd")
const DUMMY_ICON_RES: Resource = preload("res://addons/handy_components/Dummy.svg")

var _next_dummy_idx: int
var _registered_components: PoolStringArray


func _enter_tree() -> void:
	_next_dummy_idx = 0
	_registered_components = PoolStringArray()
	var config: ConfigFile = ConfigFile.new()
	if config.load("res://addons/handy_components/manifest.cfg") == OK:
		for component in config.get_value("content", "components"):
			var name: String = component.get("name", _get_next_dummy_name())
			var base: String = component.get("base", "Node")
			var script_res: Resource = load("res://addons/handy_components/" + component.get("script", "Dummy.gd"))
			var icon_res: Resource = load("res://addons/handy_components/" + component.get("icon", "Dummy.svg"))
			if not script_res:
				push_warning(WPREFIX + WC001)
				script_res = DUMMY_SCRIPT_RES
			if not icon_res:
				push_warning(WPREFIX + WC002)
				icon_res = DUMMY_ICON_RES
			add_custom_type(name, base, script_res, icon_res)
			_registered_components.append(name)


func _exit_tree() -> void:
	for component in _registered_components:
		remove_custom_type(component)


func _get_next_dummy_name() -> String:
	_next_dummy_idx += 1
	return "Dummy" + str(_next_dummy_idx)
