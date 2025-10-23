extends Node2D
#NOT COMPLETE: Still working to get the proper tracking of robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Bedroom/floor.local_to_map($robot.position))
	
	#pass # Replace with function body.


#var time_accum = 0.0
var visited_tiles = {}
var perc_cleaned = 0.0
var final_performance = 0.0
var performance = 0.0
@onready var timer = $Timer
@onready var label = $Timer2


func _process(delta):
	var room1Label = $Room1Score
	#var room2Label = $Room2Score
	var time_left = timer.get_time_left()
	label.set_text(str(time_left).pad_decimals(1))
	$Bedroom/floor.set_cell(Vector2i(-33,-22), 5, Vector2i(16,5),0)
	var tile_pos = $Bedroom/floor.local_to_map($robot.position)
	var total_tiles = 1196-60#240 - 63
	#print($Bedroom/floor.get_cell_source_id(tile_pos))
	if not visited_tiles.has(tile_pos):
		visited_tiles[tile_pos] = true
		#$Floorplan/floor.set_cell(tile_pos, -1)
		#$Bedroom/floor.erase_cell(tile_pos)
		$Bedroom/floor.set_cell(tile_pos, 11, Vector2i(18,16),0)
		#$Floorplan/floor.set_cells_terrain_connect([tile_pos], 0, 0)
		#print("visted new tile: ", tile_pos, " and size: ", visited_tiles.size())
		perc_cleaned = float(visited_tiles.size()) / total_tiles * 100
		print("Tiles cleaned: %d / %d (%.2f%%)" % [visited_tiles.size(), total_tiles, perc_cleaned])
		performance =  "%.2f" % perc_cleaned
		room1Label.text = "Score: " + str(performance)
	




func _on_timer_timeout() -> void:

	final_performance =  "%.2f" % perc_cleaned
	print("final performance metrics: ", final_performance, "%", "visited tiles set: ", visited_tiles)
	pass # Replace with function body.
