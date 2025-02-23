extends Node

var music = load("res://sounds/BGM.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_music()
	pass # Replace with function body.

func play_music():
	$Music.stream = music
	$Music.play()

func stop_music():
	$Music.stop()
