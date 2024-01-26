class_name MagicWand
extends Area2D

signal magicWandShoot(bullet, direction, location);
signal magicWandAltFire(bullet)

var bullet = preload("res://Scenes/Weapons/MagicWandBullet.tscn");
var darkBullet = preload("res://Scenes/Weapons/MagicWandBulletDark.tscn");
var readyToShoot = true;

var speedUpgrade = 0.0;
var damageUpgrade = 0;
var pierceUpgrade = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func shoot(startRotation, startPosition):
	if(readyToShoot == true):
		$AttackTimer.start();
		readyToShoot = false;
		magicWandShoot.emit(bullet, startRotation, startPosition);
	pass;

func altShoot(startRotation, startPosition):
	if(readyToShoot == true):
		magicWandShoot.emit(darkBullet, startRotation, startPosition);


func _on_attack_timer_timeout() -> void:
	readyToShoot = true;

func levelUp(upgradeType: WeaponUpgrades.WandUpgrades):
	match upgradeType:
		WeaponUpgrades.WandUpgrades.DAMAGE:
			damageUpgrade += 1;
			print("Wand damage upgraded");
		WeaponUpgrades.WandUpgrades.BULLET_SPEED:
			speedUpgrade += 20;
			print("Wand speed upgraded");
		WeaponUpgrades.WandUpgrades.PIERCING:
			pierceUpgrade += 1;
			print("Wand pierce upgraded");

func getRandomUpgrade() -> WeaponUpgrades.WandUpgrades:
	var randomUpgrade = WeaponUpgrades.WandUpgrades.values()[randi() % WeaponUpgrades.WandUpgrades.size()];
	return randomUpgrade;	
