extends Area2D

var bulletSpeed = 120.0
var direction = Vector2(0,0)
var damage = 5
var readyToDie = false
@onready var start = self.global_position
@onready var player = get_tree().get_first_node_in_group("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = position.direction_to(player.global_position)
	var velocity = bulletSpeed * direction
	position += velocity * delta
	if readyToDie == true:
		queue_free()

func _on_area_2d_area_entered(area):
	var parent = area.get_parent();
	if(parent.is_in_group("Player") == true):
		parent.damagePlayer(damage);
		readyToDie = true
		
func _on_timer_timeout():
	readyToDie = true
	pass # Replace with function body.
