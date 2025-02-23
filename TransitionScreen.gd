extends CanvasLayer
class_name TransitionScreen

signal transitioned

static var WhichInstance: TransitionScreen;
@export var nextScene: PackedScene

func _ready():
	$AnimationPlayer.play("fade_to_normal")
	WhichInstance = self

func start_transition(_scene: PackedScene):
	nextScene = _scene
	transition()

func transition():
	$AnimationPlayer.play("fade_to_black")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		print()
		emit_signal("transitioned")
		get_tree().change_scene_to_packed(nextScene)
	if anim_name == "fade_to_normal":
		print("finished fade")
