extends TextureButton
class_name OldInteractable

@export var jump_label: String = "";
@export var item_name: String = "";

@export var can_repeat: bool;
@onready var triggered: bool = false

func _on_pressed() -> void:
	if !can_repeat and triggered:
		return

	if jump_label != "":
		GameState.goto_label(jump_label)
		GameState.unpause()
	triggered = true
	
	if item_name != "":
		GameState.add_item(item_name)
	
