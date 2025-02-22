extends TextureButton

var inventory: Inventory

func _ready():
	inventory = get_tree().get_first_node_in_group("Inventory")

func _process(delta: float) -> void:
	position = get_global_mouse_position()

func enter(item: String):
	if not is_interactable(item):
		return
	if item == "MagnifyingGlass":
		get_node(item).visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func exit(item: String):
	if not is_interactable(item):
		return
	if item == "MagnifyingGlass":
		get_node(item).visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func is_interactable(item: String):
	if not inventory.selected_item and item == "MagnifyingGlass":
		return true
	if inventory.selected_item and item == inventory.selected_item.item_name:
		return true
	return false
