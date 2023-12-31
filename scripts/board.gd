extends Node2D


var board_size := Vector2(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height")
)
var cell_size := Vector2(32, 32)

var board_positions: Dictionary = {}
var board_positions_occupied: Dictionary:
	set(value): pass
	get:
		var occupied_positions = {}
		for pos in board_positions:
			if board_positions[pos] == null: continue
			occupied_positions[pos] = board_positions[pos]
		return occupied_positions
var board_positions_empty: Dictionary:
	set(value): pass
	get:
		var empty_positions = {}
		for pos in board_positions:
			if board_positions[pos] != null: continue
			empty_positions[pos] = null
		return empty_positions

var food_amount := MinMax.new(1, 5)
var inner_walls_amount := MinMax.new(5, 9)

@export var scn_floors: Array[PackedScene] = []
@export var scn_outler_walls: Array[PackedScene] = []
@export var scn_inner_walls: Array[PackedScene] = []

@export var scn_foods: Array[PackedScene] = []

@export var scn_player: PackedScene = null
@export var scn_exit: PackedScene = null


func _ready():
	init_board_positions()
	
	place_player()
	place_exit()
	
	generate_floors()
	generate_outer_wall()
	generate_inner_wall()
	
	generate_foods()


func _process(delta):
	pass


func init_board_positions() -> void:
	for x in range(0, board_size.x, cell_size.x):
		for y in range(0, board_size.y, cell_size.y):
			board_positions[Vector2(x, y)] = null


func place_player() -> void:
	const pos = Vector2(32, 256)
	
	Utils.instance_on_parent(self, scn_player, pos)
	board_positions[pos] = "player"


func place_exit() -> void:
	const pos = Vector2(256, 32)
	
	Utils.instance_on_parent(self, scn_exit, pos)
	board_positions[pos] = "exit"


func generate_floors() -> void:
	for pos in board_positions:
		Utils.instance_on_parent(self, scn_floors.pick_random(), pos)


func generate_outer_wall() -> void:
	for pos in board_positions:
		if !(pos.x == 0 or pos.x == 288 or pos.y == 0 or pos.y == 288): continue
		
		Utils.instance_on_parent(self, scn_outler_walls.pick_random(), pos)
		board_positions[pos] = "outler_wall"


func generate_inner_wall() -> void:
	var count = randi_range(inner_walls_amount.minimum, inner_walls_amount.maximum)
	
	for i in count:
		var pos = board_positions_empty.keys().pick_random()
		Utils.instance_on_parent(self, scn_inner_walls.pick_random(), pos)
		board_positions[pos] = "inner_wall"


func generate_foods() -> void:
	var count = randi_range(food_amount.minimum, food_amount.maximum)
	
	for i in count:
		var pos = board_positions_empty.keys().pick_random()
		Utils.instance_on_parent(self, scn_foods.pick_random(), pos)
		board_positions[pos] = "food"

