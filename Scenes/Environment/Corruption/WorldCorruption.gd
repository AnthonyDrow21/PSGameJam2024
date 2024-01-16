extends Area2D

func _on_activation_timer_timeout():
	$Area2D.set_collision_layer_value(2, true)
