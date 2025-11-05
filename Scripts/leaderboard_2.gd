extends Control

var all_scores: Array[float] = []

func _ready():
	var csv_data = load_csv_as_array(Paths.CSV_PATH)
	if csv_data:
		print("CSV data loaded successfully:")
		for row in csv_data:
			if row.size() > 3:
				var player_name = row[0]
				var player_times = str_to_var(row[3])
				if player_times.size() > 3:
					print(player_name, ": ", player_times[3])
					all_scores.append([player_name, player_times[3]])
		
		all_scores.sort_custom(compare_values)
		print(all_scores)
func load_csv_as_array(file_path: String) -> Array:
	var data_array: Array = []
	var file = FileAccess.open(file_path, FileAccess.READ)

	if file == null:
		printerr("Error opening CSV file: %s" % error_string(FileAccess.get_open_error()))
		return []

	# Optional: Skip header row if your CSV has one
	# file.get_line() 

	while not file.eof_reached():
		var line_array: PackedStringArray = file.get_csv_line()
		if not line_array.is_empty():
			data_array.append(line_array)

	file.close()
	return data_array

func compare_values(a, b):
	# This function is used by sort_custom to compare two elements
	# 'a' and 'b' are inner arrays like [key, value]
	return a[1] < b[1] # Sorts in ascending order of values
