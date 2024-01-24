extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")

@export var xpAmount = 3.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_area_entered(area):
	var parent = area.get_parent();
	if(parent.is_in_group("Player") == true): 
		player.gainXp(xpAmount);
		queue_free()
