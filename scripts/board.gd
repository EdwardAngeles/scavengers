extends Node2D


var viewport_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
var viewport_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")

const cell_size_width := 32
const cell_size_height := 32

const scn_outler_walls = [
	preload("res://nodes/outler_wall_0.tscn"),
	preload("res://nodes/outler_wall_1.tscn")
]

func _ready():
	generate_outler_wall()


func _process(delta):
	pass


func generate_outler_wall():
	for x in range(0, viewport_width, cell_size_width):
		for y in range(0, viewport_height, cell_size_height):
			if x == 0 or x == 288 or y == 0 or y == 288:
				var outlet_wall_instance = Utils.choose(scn_outler_walls).instantiate()
				outlet_wall_instance.position = Vector2(x, y)
				add_child(outlet_wall_instance)
	pass
