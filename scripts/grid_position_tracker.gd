class_name GridPositionTracker
extends Node

var _positions: Array[Vector2] = []
var _cell_size: int
var _grid_size: int


func _init(cell_size: int, grid_size: int) -> void:
	_cell_size = cell_size
	_grid_size = grid_size
	
	_init_positions()


func _init_positions() -> void:
	_positions.clear()
	for x in range(0, _grid_size, _cell_size):
		for y in range(0, _grid_size, _cell_size):
			_positions.append(Vector2(x, y))


func remove_position(position: Vector2) -> void:
	_positions.erase(position)


func get_and_remove_random_position() -> Vector2:
	var rand_index = randi_range(0, _positions.size()-1)
	var rand_position = _positions[rand_index]
	_positions.remove_at(rand_index)
	return rand_position
