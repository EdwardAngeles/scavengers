extends Node2D


var viewport_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")

const cell_size_width := 32
const cell_size_height := 32 

@export var scn_outler_walls : Array[PackedScene] = []
@export var scn_floors : Array[PackedScene] = []

func _ready():
	generate_outler_wall()
	generate_floors()


func _process(delta):
	pass


func generate_outler_wall() -> void:
	for x in range(0, viewport_width, cell_size_width):
		for y in range(0, viewport_height, cell_size_height):
			if x == 0 or x == 288 or y == 0 or y == 288:
				Utils.instance_on_parent(self, scn_outler_walls.pick_random(), Vector2(x, y))


func generate_floors() -> void:
	for x in range(cell_size_width, viewport_width - cell_size_width, cell_size_width):
		for y in range(cell_size_height, viewport_height - cell_size_height, cell_size_height):
			Utils.instance_on_parent(self, scn_floors.pick_random(), Vector2(x, y))


func generate_inner_wall() -> void:
	pass

