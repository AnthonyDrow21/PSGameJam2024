class_name HUD;
extends CanvasLayer;

var mainLevel = load("res://Scenes/Levels/Main1.tscn")
var mainMenu = load("res://Scenes/UI/MainMenuUI.tscn")

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var main = get_parent();
@onready var corruptionInfo: CorruptionInfo = get_tree().current_scene.worldCorruption;

@onready var corruptionBar = self.find_child("CorruptionBar");
@onready var corruptionTier = self.find_child("CorruptionTier");
var maxTime;
var currentTime: float = 0.0;
var minutesLeft: int = 0;
var secondsLeft: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxTime = main.maxTime;
	main.pausePressed.connect(pauseTimer);
	main.unpausePressed.connect(unPauseTimer);
	player.playerDied.connect(pauseTimer);
	
	$RetryButton.hide();
	$MainMenuButton.hide();
	
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
	updateXPBars();
	updateCorruptionBars();
	pass

func showGameOver():
	$ScreenMessage.show();
	$RetryButton.show();
	$MainMenuButton.show();

func updateXPBars():
	$CurrentLevel.text = str(player.currentLevel);
	$DarkLevelBar.max_value = player.requiredXp;
	$DarkLevelBar.value = player.currentXp;
	$LightLevelBar.max_value = player.requiredXp;
	$LightLevelBar.value = player.currentXp;

func updateCorruptionBars():
	corruptionBar.max_value = corruptionInfo.corruptionThreshold;
	corruptionBar.value = corruptionInfo.corruption;
	corruptionTier.text = str(corruptionInfo.corruptionTier);

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


func _on_retry_button_pressed() -> void:
	get_tree().paused = false;
	get_tree().reload_current_scene();


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_packed(mainMenu);

func pauseTimer():
	$ClockTimer.set_paused(true);

func unPauseTimer():
	$ClockTimer.set_paused(false);

func setMessage(str):
	$ScreenMessage.text = str;

func _on_clock_timer_timeout() -> void:
	currentTime += 1.0;
	if(currentTime == maxTime):
		$ClockTimer.stop();
		main.gameOver();
	#var minutes = fmod(currentTime, 3600) / 60;
	minutesLeft = (maxTime - currentTime) / 60;
	secondsLeft = fmod(maxTime - currentTime, 60);
	$Timer.text = "%02d:%02d" % [minutesLeft, secondsLeft];
