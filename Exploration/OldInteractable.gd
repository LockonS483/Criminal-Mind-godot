extends TextureButton
class_name OldInteractable

@export var jump_label: String = "";
@export var item_name: String = "";

@export var can_repeat: bool;
@onready var triggered: bool = false

<<<<<<< HEAD
func _on_pressed() -> void:
	if !can_repeat and triggered:
		return

	if jump_label != "":
		GameState.goto_label(jump_label)
		GameState.unpause()
	triggered = true
	
	if item_name != "":
		GameState.add_item(item_name)
=======
func _gui_input(event: InputEvent):
	if !can_repeat and triggered:
		return
		
	if event is InputEventMouseButton and event.pressed:
		print("mouse click hehe")
		if jump_label != "":
			GameState.goto_label("~Phone")
			GameState.unpause()
		triggered = true
		
		if item_name != "":
			GameState.add_item(item_name)

func _on_pressed() -> void:
	print("bruh")
>>>>>>> 3abf2e890394ccc5b78049517f0abe6500fcfd51
	
