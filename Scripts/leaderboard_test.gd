extends Node2D

@onready var simpleboards = $SimpleBoardsApi
const leaderboard_id = "b424453d-081b-4666-0528-08de1bc660ae"

func _ready():
	# Set the API key
	if simpleboards == null:
		print("ERROR: SimpleBoardsApi node not found!")
		print("Available children:")
		for child in get_children():
			print(" - ", child.name)
		return
	simpleboards.set_api_key(EnvPaths.API_KEY)
	
	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	simpleboards.entry_sent.connect(_on_entry_sent)
	
	# Send a score
	await simpleboards.send_score_without_id(leaderboard_id, Global.current_student.first_name, str(Global.current_student.performance_history), "")
	#await simpleboards.send_score_with_id(leaderboard_id, "Kay - Test", "65.5", "{}", "1")
	
	# Get leaderboard entries
	await simpleboards.get_entries(leaderboard_id)

func _on_entries_got(entries):
	print("\n=== LEADERBOARD ===")
	for i in range(entries.size()):
		print(i+1, ". ", entries[i].get("name", "Unknown"), " - ", entries[i].get("score", "0"))

func _on_entry_sent(entry):
	print("✓ Score submitted!")
	print(entry)
	# Refresh leaderboard after submission
	await simpleboards.get_entries(leaderboard_id)
