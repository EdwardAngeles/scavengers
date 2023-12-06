extends Node2D


var board_size := Vector2(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height")
)
var cell_size := Vector2(32, 32)

var food_amount := MinMax.new(1, 5)
var inner_walls_amount := MinMax.new(5, 9)

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

@export var scn_floors : Array[PackedScene] = []
@export var scn_outler_walls : Array[PackedScene] = []
@export var scn_inner_walls : Array[PackedScene] = []

@onready var floors = $floors
@onready var outler_walls = $outler_walls
@onready var inner_walls = $inner_walls


func _ready():
	init_board_positions()
	
	generate_floors()
	generate_outer_wall()
	generate_inner_wall()


func _process(delta):
	pass


func init_board_positions() -> void:
	for x in range(0, board_size.x, cell_size.x):
		for y in range(0, board_size.y, cell_size.y):
			board_positions[Vector2(x, y)] = null


func generate_floors() -> void:
	for pos in board_positions:
		Utils.instance_on_parent(self, scn_floors.pick_random(), pos)


func generate_outer_wall() -> void:
	for pos in board_positions:
		if !(pos.x == 0 or pos.x == 288 or pos.y == 0 or pos.y == 288): continue
		
		Utils.instance_on_parent(self, scn_outler_walls.pick_random(), pos)
		board_positions[pos] = "outler_wall"


func generate_inner_wall() -> void:
	var count = randi_range(inner_walls_amount.min, inner_walls_amount.max)
	
	for i in count:
		var random_position = board_positions_empty.keys().pick_random()
		Utils.instance_on_parent(self, scn_inner_walls.pick_random(), random_position)
		board_positions[random_position] = "inner_walls"

