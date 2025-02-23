extends Control
class_name InventorySlot

@export var inventory_item_scene: PackedScene = preload("res://Inventory/Items/InventoryItem.tscn")

@export var item: InventoryItem
@export var hint_item: InventoryItem = null #used for restricting slot to only accept x item

enum InventorySlotAction{
	SELECT, USE
}

signal slot_input(which: InventorySlot, action: InventorySlotAction)
signal slot_hovered(which: InventorySlot, is_hovering: bool)

func _ready():
	add_to_group("inventory_slots")

# input functions
func _on_texture_button_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			slot_input.emit(self, InventorySlotAction.SELECT)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			slot_input.emit(self, InventorySlotAction.USE)
func _on_texture_button_mouse_entered():
	slot_hovered.emit(self, true)
func _on_texture_button_mouse_exited():
	slot_hovered.emit(self, false)


#utility functions
func is_empty():
	return self.item == null
func has_same_item(_item: InventoryItem):
	return _item.item_name == self.item.item_name
func update_slot():
	if item:
		if not self.get_children().has(item):
			add_child(item)
		#item.sprite.texture = item.icon
		#item.label.text = str(item.amount) + " - " + str(item.name)
		# If amount ios 0, make iot semi-transparent
		if item.amount < 1:
			item.fade()

# Removes item from slot
func remove_item():
	if(item != null):
		self.remove_child(item)
		item.free()
		item = null
	update_slot()

func select_item() -> InventoryItem:
	var inventory = self.get_parent().get_parent();
	var tmp_item := self.item
	if tmp_item:
		tmp_item.reparent(inventory)
		self.item = null
		tmp_item.z_index = 128
	return tmp_item
	
func use_item():
	print("used")

# If swap, then returb swapped item, else return null and add new item
func deselect_item(new_item: InventoryItem) -> InventoryItem:
	var inventory = self.get_parent().get_parent() # Inventory
	if self.is_empty():
		new_item.reparent(self)
		self.item = new_item
		self.item.z_index = 64
		return null
	else:
		if self.has_same_item(new_item): # if both items are same
			print("Has same item")
			self.item.amount += new_item.amount
			new_item.free()
			return null
		else: # if different type, swap
			new_item.reparent(self) # Make new thing our child
			self.item.reparent(inventory) # make old thing inventory child
			var tmp_item = self.item
			self.item = new_item
			new_item.z_index = 64 # Reset its z index
			tmp_item.z_index = 128 # Update swapped item's z index
			return tmp_item
