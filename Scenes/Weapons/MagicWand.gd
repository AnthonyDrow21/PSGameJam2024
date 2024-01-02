class_name MagicWand
extends Area2D

signal magicWandShoot(bullet, direction, location);

var bullet = preload("res://Scenes/Weapons/MagicWandBullet.tscn");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass;

func shoot(startRotation, startPosition):
	magicWandShoot.emit(bullet, startRotation, startPosition);
	pass;
