extends Node


func _ready():
	pass


func _process(delta):
	pass


func choose(choises):
	return choises[randi_range(0, choises.size()-1)]

func instance_on_parent(parent_node: Node, scene_to_instantiate: PackedScene, position: Vector2) -> Node:
	var instance := scene_to_instantiate.instantiate()
	if instance is Node2D:
		instance.position = position
	parent_node.add_child(instance)
	return instance
