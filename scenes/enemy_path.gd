class_name EnemyPath

extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: DifficultyManager
@export var victory_layer: CanvasLayer

@onready var spawn_timer := $SpawnTimer

func _ready() -> void:
	spawn_timer.wait_time = difficulty_manager.get_spawn_time()
	victory_layer.visible = false

## Spawn an enemy node and set a new wait_time for the spawn_timer from difficulty_manager
func spawn_enemy() -> void:
	var new_enemy: Enemy = enemy_scene.instantiate()
	new_enemy.max_health = int(difficulty_manager.get_enemy_health())
	new_enemy.tree_exited.connect(enemy_defeated)
	add_child(new_enemy)
	spawn_timer.wait_time = difficulty_manager.get_spawn_time()

func _on_difficulty_manager_stop_spawning_enemies() -> void:
	spawn_timer.stop()

func enemy_defeated() -> void:
	if spawn_timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return
		victory_layer.visible = true
