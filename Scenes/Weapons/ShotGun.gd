class_name ShotGun
extends Area2D

signal shotGunShoot(bullet, direction, location);

#TODO# Will need a new scene for the shotgun's bullet
var bullet = preload("res://Scenes/Weapons/ShotGunBullet.tscn");
var darkBullet = preload("res://Scenes/Weapons/ShotGunBulletDark.tscn");
var readyToShoot = true;

var speedUpgrade = 0.0;
var damageUpgrade = 0;

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
		shotGunShoot.emit(bullet, startRotation, startPosition);
	pass;

func altShoot(startRotation, startPosition):
	if(readyToShoot == true):
		$AttackTimer.start();
		readyToShoot = false;
		shotGunShoot.emit(darkBullet, startRotation, startPosition);
		pass;
	pass;

func _on_attack_timer_timeout() -> void:
	readyToShoot = true;

func levelUp():
	damageUpgrade += 1;
