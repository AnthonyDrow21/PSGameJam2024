extends CanvasLayer

@onready var main = get_parent();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide the pause screen by default.
	hide();
	
	main.pausePressed.connect(OnPause);
	main.unpausePressed.connect(OnUnpause);
	pass # Replace with function body.


func OnPause():
	show();

func OnUnpause():
	hide();

func _on_exit_button_pressed() -> void:
	get_tree().quit();

func _on_resume_button_pressed() -> void:
	OnUnpause();
	main.onUnpause();
