extends Node2D

@export var inv_scene: PackedScene = preload("res://Inventory/Inventory.tscn")
@onready var inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = inv_scene.instantiate()
	add_child(inventory)
	print("ready")
	
	Dialogic.start("p1_test")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
