extends TextureButton
class_name OldInteractable

@export var jump_label: String = "";
@export var item_name: String = "";

@export var can_repeat: bool;
@onready var triggered: bool = false

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
	
