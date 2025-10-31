class_name DifficultyManager

extends Node3D

signal stop_spawning_enemies

@export var spawn_time_curve: Curve
@export var enemy_health_curve: Curve
@export var level_length := 30.0
@export var enemy_path: EnemyPath

@onready var level_timer := $LevelTimer

func _ready() -> void:
	level_timer.start(level_length)
	
## Return a value from 0.0 to 1.0 where 1.0 is the end of the level_length and 0.0 is the start
func game_progress_ratio() -> float:
	return 1.0 - (level_timer.time_left / level_length)

## Pull the spawn interval from the spawn_time_curve via the return value of game_progress_ratio()
func get_spawn_time() -> float:
	return spawn_time_curve.sample(game_progress_ratio())
	
func get_enemy_health() -> float:
	return enemy_health_curve.sample(game_progress_ratio())


func _on_level_timer_timeout() -> void:
	stop_spawning_enemies.emit()
