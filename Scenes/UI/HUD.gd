class_name HUD;
extends CanvasLayer;

# Max time in seconds
var maxTime = 1800.0;

var currentTime: float = 0.0;
var minutesLeft: int = 0;
var secondsLeft: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minutesLeft = (maxTime - currentTime) / 60;
	secondsLeft = fmod(maxTime, 60);
	$Timer.text = "%02d:%02d" % [minutesLeft, secondsLeft];
	
	$ScreenMessage.hide();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currentTime += delta;
	#var minutes = fmod(currentTime, 3600) / 60;
	minutesLeft = (maxTime - currentTime) / 60;
	secondsLeft = fmod(maxTime - currentTime, 60);
	$Timer.text = "%02d:%02d" % [minutesLeft, secondsLeft];
	pass

func showGameOver():
	$ScreenMessage.show();
