extends Enemy;

@onready var mainScene = get_tree().get_root().get_node("Main")

var corruptionSpreadInterval = true
var corruptionDrip = false

func _ready():
	#movementSpeed = 30;
	#enemyHealth = 5;
	self.knockbackValue = 5;
	#$AnimationPlayer
	
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()
	if corruptionDrip == true && corruptionSpreadInterval == true:
		mainScene.mainDripCorruption(self.position)
		corruptionSpreadInterval = false

func damage_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT: 
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect

func Display_DMG(damage: int):
	var indicator = damage_effect(EnemyDMGAnim)
	if indicator:
		indicator.label.text = str(damage)
		
func _on_hitbox_area_exited(area):
	var parent = area.get_parent();
	if(parent.is_in_group("Corruption") == true):
		corruptionDrip = true
		$corruptionSpreadDuration.start()
	pass # Replace with function body.

func _on_corruption_spread_duration_timeout():
	corruptionDrip = false
	pass # Replace with function body.
	
func _on_corruption_spread_interval_timeout():
	corruptionSpreadInterval = true
	pass # Replace with function body.
