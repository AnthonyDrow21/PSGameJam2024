class_name HUD;
extends CanvasLayer;

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var corruptionInfo: CorruptionInfo = get_tree().current_scene.worldCorruption;
var maxTime;
var currentTime: float = 0.0;
var minutesLeft: int = 0;
var secondsLeft: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_parent();
	maxTime = main.maxTime;
	
	# Connect to player's invert signal on startup so we only have to do this once.
	player.playerInverted.connect(onInvert);
	updateXPBars();
	onInvert(player.isInverted);
	
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
	updateXPBars();
	pass

func showGameOver():
	$ScreenMessage.show();

func updateXPBars():
	$CurrentLevel.text = str(player.currentLevel);
	$DarkLevelBar.max_value = player.requiredXp;
	$DarkLevelBar.value = player.currentXp;
	$LightLevelBar.max_value = player.requiredXp;
	$LightLevelBar.value = player.currentXp;

###
### This function will invert the HUD of the Game based on whether we are in light mode or dark mode.
### This is connected to the players "playerInverted" signal.
###
func onInvert(isInverted):
	if(isInverted == true):
		$LightLevelBar.hide();
		$DarkLevelBar.show();
	else:
		$LightLevelBar.show();
		$DarkLevelBar.hide();
