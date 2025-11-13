extends Control
@onready var simpleboards = $SimpleBoardsApi
const leaderboard_id = "b424453d-081b-4666-0528-08de1bc660ae"
@onready var leaderboard_vbox = get_node_or_null("MarginContainer/VBoxContainer/ScrollContainer/LeaderboardVbox")
var all_scores: Array[float] = []
@onready var leaderboard_panel = $MarginContainer/VBoxContainer/ScrollContainer/LeaderboardVbox/ScoreEntry
@onready var leaderboard_theme = preload("res://Themes/ButtonTheme.theme")


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
		
	# Set the API key
	if simpleboards == null:
		print("ERROR: SimpleBoardsApi node not found!")
		print("Available children:")
		for child in get_children():
			print(" - ", child.name)
		return
	simpleboards.set_api_key("70846422-667f-4bb5-b7fa-28f5f5ef206c") #EnvPaths.API_KEY
	
	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	simpleboards.entry_sent.connect(_on_entry_sent)
	
	var perf = Global.current_student.performance_history[-1]
	var perf_string = str(round(perf * 1000) / 10) #+ "%"
	# Send a score
	await simpleboards.send_score_without_id(leaderboard_id, Global.current_student.first_name, perf_string, "")
	#await simpleboards.send_score_with_id(leaderboard_id, "Kay - Test", "65.5", "{}", "1")
	
	# Get leaderboard entries
	await simpleboards.get_entries(leaderboard_id)
	
func _on_entry_sent(entry):
	print("✓ Score submitted!")
	print(entry)
	# Refresh leaderboard after submission
	await simpleboards.get_entries(leaderboard_id)
	
	
func clear_leaderboard():
	if leaderboard_vbox == null:
		print("Leaderboard VBoxContainer node not found!")
		return
	
	for child in leaderboard_vbox.get_children():
		child.queue_free()



		
func display_leaderboard(entries):
	clear_leaderboard()
	var font = FontFile.new()
	font.font_data = load("res://Fonts/KGRedHands.ttf")
	#leaderboard_panel.theme = leaderboard_theme
	#label.add_font_override("font", font)
	for i in range(entries.size()):
		var entry = entries[i]
		var player_name = entry.get("playerDisplayName", "Unknown")
		var player_score = entry.get("score", "0")
		
		
		
		
		var label = Label.new()
		label.text = str(i + 1) + ". " + player_name + " - " + str(player_score) + "%"
		label.add_theme_font_override("font", font)
		label.add_theme_font_size_override("font_size", 80)
		label.add_theme_color_override("font_color", Color.BLACK)
		leaderboard_vbox.add_child(label)
		
func _on_entries_got(entries):
	display_leaderboard(entries)
	print("\n=== LEADERBOARD ===")
	for i in range(entries.size()):
		print(i+1, ". ", entries[i].get("playerDisplayName", "Unknown"), " - ", entries[i].get("score", "0"))


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
	
	


##func _ready():
	## Set the API key
	#if simpleboards == null:
		#print("ERROR: SimpleBoardsApi node not found!")
		#print("Available children:")
		#for child in get_children():
			#print(" - ", child.name)
		#return
	#simpleboards.set_api_key(EnvPaths.API_KEY)
	#
	## Connect signals
	#simpleboards.entries_got.connect(_on_entries_got)
	#simpleboards.entry_sent.connect(_on_entry_sent)
	#
	## Send a score
	#await simpleboards.send_score_without_id(leaderboard_id, Global.current_student.first_name, str(Global.current_student.performance_history[-1]), "")
	##await simpleboards.send_score_with_id(leaderboard_id, "Kay - Test", "65.5", "{}", "1")
	#
	## Get leaderboard entries
	#await simpleboards.get_entries(leaderboard_id)


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file(Paths.PHASE3)
