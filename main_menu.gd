extends Control
@export var StartScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trymusic()
	

func trymusic():
	await get_tree().create_timer(0.5).timeout
	print("gogo")
	Dialogic.start("menu")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://inv_test.tscn")
