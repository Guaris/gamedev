extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()
	
func _game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
func _new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_hit():
	pass # replace with function body


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offeset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))
	
