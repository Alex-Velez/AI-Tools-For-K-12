extends Node2D
#NOT COMPLETE: Still working to get the proper tracking of robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Floorplan/floor.local_to_map($robot.position))
	pass # Replace with function body.



	
	
var visited_tiles = {}
 
#var tile_pos = $Floorplan/floor.local_to_map($robot.position)

func mark_visited(tile_pos):
	visited_tiles[tile_pos] = true
	print(visited_tiles.size())
	
func get_coverage_ratio():
	var total_tiles = 240 #change this to known value or 3840
	print(total_tiles)
	return visited_tiles.size() / float(total_tiles)
	
	

	
