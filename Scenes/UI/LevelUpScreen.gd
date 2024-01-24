extends CanvasLayer

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@export var upgradeCount = 3;
@export var wandUpgradeIcon = preload("res://Assets/Icons/magic_wand_icon.jpg");
@export var shotGunUpgradeIcon = preload("res://Assets/Icons/ShotGun.jpg");
var currentUpgrades = [];
var currentWeaponIndex = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide();
	pass # Replace with function body.

func onLevelUp():
	get_tree().paused = true;
	$ItemList.clear();
	currentUpgrades.clear();
	show();
	
	for item in upgradeCount:
		var weaponSelected = player.currentWeapons[currentWeaponIndex];
		if weaponSelected is MagicWand:
			var upgrade: WeaponUpgrades.WandUpgrades = weaponSelected.getRandomUpgrade();
			var upgradeString = WeaponUpgrades.WandUpgrades.find_key(upgrade);
			$ItemList.add_item(upgradeString, wandUpgradeIcon);
			currentUpgrades.push_back(upgrade);
		elif weaponSelected is ShotGun:
			var upgrade: WeaponUpgrades.ShotGunUpgrades = weaponSelected.getRandomUpgrade();
			var upgradeString = WeaponUpgrades.ShotGunUpgrades.find_key(upgrade);
			$ItemList.add_item(upgradeString, shotGunUpgradeIcon);
			currentUpgrades.push_back(upgrade);
			pass;
	

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	# Only select an upgrade on left mouse click.
	if(mouse_button_index == 1):
		var selectedUpgrade = currentUpgrades[index];
		var weapon = player.currentWeapons[currentWeaponIndex];
		weapon.levelUp(selectedUpgrade);
		hide();
		currentWeaponIndex += 1;
		if(currentWeaponIndex > player.currentWeapons.size() - 1):
			currentWeaponIndex = 0;
		get_tree().paused = false;
	
