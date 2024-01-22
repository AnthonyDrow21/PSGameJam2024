extends CanvasLayer

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@export var upgradeCount = 3;
@export var wandUpgradeIcon = preload("res://Assets/Icons/magic_wand_icon.jpg");
var currentUpgrades = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onLevelUp():
	get_tree().paused = true;
	$ItemList.clear();
	currentUpgrades.clear();
	show();
	
	for item in upgradeCount:
		var firstWeapon = player.currentWeapons[0];
		if firstWeapon is MagicWand:
			var upgrade: WeaponUpgrades.WandUpgrades = firstWeapon.getRandomUpgrade();
			var upgradeString = WeaponUpgrades.WandUpgrades.find_key(upgrade);
			$ItemList.add_item(upgradeString, wandUpgradeIcon);
			currentUpgrades.push_back(upgrade);
	

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	# Only select an upgrade on left mouse click.
	if(mouse_button_index == 1):
		var selectedUpgrade = currentUpgrades[index];
		var wand = player.currentWeapons[0];
		wand.upgradeWand(selectedUpgrade);
		hide();
		get_tree().paused = false;
	
