extends Enemy

@onready var getPlayer = get_tree().get_first_node_in_group("res://Scenes/Player/Player.tscn")
@onready var getMain = get_tree().get_root().get_node("Main")

signal spiderBlast()
signal bossKilled(isWin)
var magicReady = false
var spiderBullet = preload("res://Scenes/NPC/Boss/spiderBullet.tscn")

func _ready():
	movementSpeed = 10
	enemyHealth = 1000
	self.spiderBlast.connect(getMain.onBossBlast)
	self.bossKilled.connect(getMain.gameOver)
	self.knockbackValue = .01;

func _physics_process(_delta):
	if magicReady == true:
		spiderBlast.emit(spiderBullet,self.position, self.rotation)
		magicReady = false
	else:
		pass
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage, incoming_dmg_pos, knockback_modifier = 1):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()
		bossKilled.emit(true);
		#TODO# If we want gems for increasing XP this is the call to start at.
		#spawn_gem(incoming_dmg_pos)
	else:
		knockback_enemy(incoming_dmg_pos, damage, knockback_modifier)

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
	magicReady = true
	pass # Replace with function body.
