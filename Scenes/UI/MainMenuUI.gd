extends CanvasLayer

var mainLevel = load("res://Scenes/Levels/Main1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().mode = Window.MODE_MAXIMIZED
	var size = get_viewport().size;
	var scale = size.x / $TitleSprite.texture.get_size().x;
	
	$TitleSprite.set_position(Vector2(size.x / 2, size.y / 2));
	$TitleSprite.set_scale(Vector2(scale, scale));
	
	#$TitleSprite.scale.x = size.x;
	#$TitleSprite.scale.y = size.y;
	pass # Replace with function body.


func _onStartGamePressed() -> void:
	get_tree().change_scene_to_packed(mainLevel);


func _onQuitPressed() -> void:
	get_tree().quit();
