extends Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_activation_timer_timeout():
	$Area2D.set_collision_layer_value(2, true)
