class_name TurretManager

extends Node3D

@export var turret_scene: PackedScene

func create_turret(turret_position: Vector3):
	var turret = turret_scene.instantiate()
	add_child(turret)
	turret.global_position = turret_position
