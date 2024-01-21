extends Area2D

@onready var player: Player = get_node("Player");

@export var xpAmount = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_entered(area):
	player.gainXp(xpAmount);
	queue_free()
