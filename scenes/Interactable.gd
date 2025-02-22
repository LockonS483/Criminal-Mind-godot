extends TextureButton
class_name Interactable

@export var item_type: String
@export var destroy_item = false
# Set it to some unique ID to make it self-destruct and remember
@export var self_destruct_id = 0
@export var goto_label: String
@export var flag_name: String = ""
var CURSOR_ITEM

func _ready() -> void:
	if GameState.is_self_destruct(self_destruct_id):
		queue_free()
	CURSOR_ITEM = get_tree().get_first_node_in_group("CursorItem")

func can_exist() -> bool:
	if flag_name == "":
		return true
	
	return !GameState.check_flag(flag_name)

func _on_mouse_entered() -> void:
	if not can_exist():
		return
	
	if not CURSOR_ITEM.is_interactable(item_type):
		return
	CURSOR_ITEM.enter(item_type)

func _on_mouse_exited() -> void:
	if not can_exist():
		return
	
	if not CURSOR_ITEM.is_interactable(item_type):
		return
	CURSOR_ITEM.exit(item_type)

func _on_pressed() -> void:
<<<<<<< HEAD
	print("pressed")
	if not can_exist():
		return
	
	if item_type == "":
		trigger_interact()
		return
	
=======
	if not can_exist():
		return
		
>>>>>>> 3abf2e890394ccc5b78049517f0abe6500fcfd51
	if not CURSOR_ITEM.is_interactable(item_type):
		return
	
	trigger_interact();

func trigger_interact():
	#visible = false
	
	if item_type != "":
		CURSOR_ITEM.exit(item_type)
	
	if destroy_item:
		# Not tested
		CURSOR_ITEM.inventory.selected_item.queue_free()
		CURSOR_ITEM.inventory.selected_item = null
		
	if goto_label:
		GameState.unpause()
		GameState.goto_label(goto_label)
		
	if self_destruct_id:
		GameState.self_destruct(self_destruct_id)
	
	if flag_name != "":
		GameState.set_flag(flag_name, true)
