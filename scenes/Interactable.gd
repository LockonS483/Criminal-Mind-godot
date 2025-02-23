extends TextureButton
class_name Interactable

@export var item_type: String
@export var other_items = []
@export var associated_sprite: Node2D
@export var destroy_item = false
# Set it to some unique ID to make it self-destruct and remember
@export var self_destruct_id = 0
@export var goto_label: String
@export var flag_name: String = ""
var CURSOR_ITEM

func _ready() -> void:
	if GameState.is_self_destruct(self_destruct_id):
		queue_free()
	if associated_sprite != null:
		if flag_name != null:
			if GameState.check_flag(flag_name):
				associated_sprite.visible = false
	
	CURSOR_ITEM = get_tree().get_first_node_in_group("CursorItem")

func can_exist() -> bool:
	if flag_name == "":
		return true
	
	if not Dialogic.paused:
		return false
	
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
	print("pressed")
	if not can_exist():
		return
	
	if item_type == "":
		trigger_interact()
		return
	
	var is_right_item = false
	if CURSOR_ITEM.is_interactable(item_type):
		is_right_item = true
	else:
		if other_items.size() > 0:
			for itm in other_items:
				print(itm)
				if CURSOR_ITEM.is_interactable(itm):
					is_right_item = true
	if not is_right_item:
		return
	
	trigger_interact();

func trigger_interact():
	if associated_sprite != null:
		associated_sprite.visible = false
	
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
