extends Enemy

@onready var getPlayer = get_tree().get_first_node_in_group("res://Scenes/Player/Player.tscn")
@onready var getMain = get_tree().get_root().get_node("Main")

signal wizardBlast()
var magicReady = false
var wizardBullet = preload("res://Scenes/NPC/Wizard/wizardBullet.tscn")

func _ready():
	var movementSpeed = 15
	var enemyHealth = 10

func _physics_process(_delta):
	if magicReady == true:
		wizardBlast.emit(wizardBullet,self.position, self.rotation)
		magicReady = false
	else:
		pass
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()

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

func _on_bomb_timer_timeout():
	var magicReady = true
	pass # Replace with function body.
