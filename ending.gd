extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.unpause()
	Dialogic.start("true_ending")
	
