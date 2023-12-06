extends Node2D


var viewport_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")

const cell_size_width := 32
const cell_size_height := 32 

@export var scn_floors : Array[PackedScene] = []
@export var scn_outler_walls : Array[PackedScene] = []
@export var scn_inner_walls : Array[PackedScene] = []

@onready var floors = $floors
@onready var outler_walls = $outler_walls
@onready var inner_walls = $inner_walls

const inner_walls_count_min = 5
const inner_walls_count_max = 9

var food_count_min = 1
var food_count_max = 5


func _ready():
	#_init_grid_positions_available()
	
	generate_floors()
	generate_outler_wall()
	generate_inner_wall()


func _process(delta):
	pass


func generate_floors() -> void:
	for x in range(0, viewport_width, cell_size_width):
		for y in range(0, viewport_height, cell_size_height):
			Utils.instance_on_parent(floors, scn_floors.pick_random(), Vector2(x, y))


func generate_outler_wall() -> void:
	for x in range(0, viewport_width, cell_size_width):
		for y in range(0, viewport_height, cell_size_height):
			if x == 0 or x == 288 or y == 0 or y == 288:
				Utils.instance_on_parent(outler_walls, scn_outler_walls.pick_random(), Vector2(x, y))


func generate_inner_wall() -> void:
	var count = randi_range(inner_walls_count_min, inner_walls_count_max)
	
	for i in range(count):
		var random_x = randi_range(cell_size_width , viewport_width  - (2 * cell_size_width ))
		var random_y = randi_range(cell_size_height, viewport_height - (2 * cell_size_height))
		var random_position = Vector2(random_x, random_y)
		Utils.instance_on_parent(inner_walls, scn_inner_walls.pick_random(), random_position)
	pass


#func _init_grid_positions_available() -> void:
	#grid_positions_available.clear()
	#for x in range(0, viewport_width, cell_size_width):
		#for y in range(0, viewport_height, cell_size_height):
			#grid_positions_available.append(Vector2(x, y))
#
#

#func get_random_position():
	#var rand_index = randi_range(0, grid_positions_available.size()-1)
	#var rand_position = grid_positions_available[rand_index]
	#grid_positions_available.remove_at(rand_index)
	#return rand_position
	#pass





