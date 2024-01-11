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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass;

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

func lightLevelUp():
	damageUpgrade += 1;

func darkLevelUp():
	pierceUpgrade += 1;
	pass;
