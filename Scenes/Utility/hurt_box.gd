extends Area2D

##Multiple different "Hurtboxes" in the same script, exenum used to facilitate
@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #Cooldown
					collision.call_deferred("set","disable",true)
					disableTimer.start()
				1: #HitOnce
					pass
				2: #DisableHitBox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt",damage)


func _on_disable_timer_timeout():
	collision.call_deferred("set","disable",false)
	pass # Replace with function body.
