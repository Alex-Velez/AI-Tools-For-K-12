extends Node2D
#NOT COMPLETE: Still working to get the proper tracking of robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Floorplan/floor.local_to_map($robot.position))
	#pass # Replace with function body.


#var time_accum = 0.0
var visited_tiles = {}
var perc_cleaned = 0.0
var final_performance = 0.0

func _process(delta):
	
	
	var tile_pos = $Floorplan/floor.local_to_map($robot.position)
	var total_tiles = 240 - 63
	if not visited_tiles.has(tile_pos):
		visited_tiles[tile_pos] = true
		#$Floorplan/floor.set_cell(tile_pos, -1)
		$Floorplan/floor.erase_cell(tile_pos)
		#$Floorplan/floor.set_cells_terrain_connect([tile_pos], 0, 0)
		#print("visted new tile: ", tile_pos, " and size: ", visited_tiles.size())
		perc_cleaned = float(visited_tiles.size()) / total_tiles * 100
		print("Tiles cleaned: %d / %d (%.2f%%)" % [visited_tiles.size(), total_tiles, perc_cleaned])
	
	

	


func _on_timer_timeout() -> void:
	final_performance =  "%.2f" % perc_cleaned
	print("final performance metrics: ", final_performance, "%")
	pass # Replace with function body.
