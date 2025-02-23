extends Node

var destructed_nodes = []
@onready var game_flags = {}


func pause():
	Dialogic.paused = true
	for input_blocker in get_tree().get_nodes_in_group("InputBlocker"):
		input_blocker.visible = false
	get_tree().root.get_node("DialogicLayout_DialogicStyle/FullAdvanceInputLayer").visible = false

func unpause():
	for input_blocker in get_tree().get_nodes_in_group("InputBlocker"):
		input_blocker.visible = true
	get_tree().root.get_node("DialogicLayout_DialogicStyle/FullAdvanceInputLayer").visible = true
	Dialogic.paused = false

func goto_label(label: String):
	unpause()
	Dialogic.Jump.jump_to_label(label)

func add_item(item_name: String):
	Inventory.WhichInstance.spawn_item(item_name);

func self_destruct(id):
	destructed_nodes.push_back(id)

func is_self_destruct(id):
	return id in destructed_nodes


func check_flag(flag_name: String) -> bool:
	if !game_flags.has(flag_name):
		return false
	
	return game_flags[flag_name]

func set_flag(flag_name: String, val: bool) -> void:
	game_flags[flag_name] = val
	
func Set_Dialogic_variable(vname: String, val: Variant):
	Dialogic.VAR.set_variable(vname, val)

func New_Playthrough():
	Inventory.WhichInstance.clear_inventory()
	game_flags = {}
	destructed_nodes = []
	Dialogic.VAR.reset()

func Back_to_Menu():
	New_Playthrough()
	get_tree().get_first_node_in_group("Inventory").queue_free()
	get_tree().change_scene_to_file("res://main_menu.tscn")
