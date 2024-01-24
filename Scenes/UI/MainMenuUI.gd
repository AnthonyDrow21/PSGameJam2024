extends CanvasLayer

var mainLevel = load("res://Scenes/Levels/Main1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _onStartGamePressed() -> void:
	get_tree().change_scene_to_packed(mainLevel);


func _onQuitPressed() -> void:
	get_tree().quit();
