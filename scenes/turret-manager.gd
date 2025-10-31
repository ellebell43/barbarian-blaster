class_name TurretManager

extends Node3D

@export var turret_scene: PackedScene
@export var enemy_path: Path3D

func create_turret(turret_position: Vector3):
	var space_occupied = false
	for item in get_children():
		if item.global_position == turret_position:
			space_occupied = true
	
	if not space_occupied:
		var turret: Turret = turret_scene.instantiate()
		add_child(turret)
		turret.global_position = turret_position
		turret.enemy_path = enemy_path
