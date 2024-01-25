extends Area2D

var bulletSpeed = 90.0
var damage = 10
var readyToDie = false
@onready var start = self.global_position
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var getMain = get_tree().get_root().get_node("Main")
@onready var summonSpiders = preload("res://Scenes/NPC/SpiderMinion/spiderMinion.tscn")
@onready var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
var radius = Vector2(40,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = bulletSpeed * direction
	position += velocity * delta
	if readyToDie == true:
		queue_free()

func _on_area_2d_area_entered(area):
	var parent = area.get_parent();
	if(parent.is_in_group("Player") == true):
		player.damagePlayer(damage)
		getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
		getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
		getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
		getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
		readyToDie = true
	elif(parent.is_in_group("Projectile") == true):
		readyToDie = true
		pass
		
func _on_timer_timeout():
	readyToDie = true
	getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
	getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
	getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
	getMain.summonSpiders(summonSpiders, self.position + radius.rotated(randf_range(-PI, PI)))
	pass # Replace with function body.
	
	
