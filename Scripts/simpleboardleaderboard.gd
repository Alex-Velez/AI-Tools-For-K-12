extends Node2D


@onready var simpleboards = $SimpleBoardsApi
const leaderboard_id = "b424453d-081b-4666-0528-08de1bc660ae"

func _ready():
	
	# Set the API key
	simpleboards.set_api_key(EnvPaths.API_KEY)
	
	# Connect signals
	simpleboards.entries_got.connect(_on_entries_got)
	simpleboards.entry_sent.connect(_on_entry_sent)
	
	# Send a score
	await simpleboards.send_score_without_id(leaderboard_id, Global.current_student.first_name, Global.current_student.performance_history[-1], "{}")
	#await simpleboards.send_score_with_id(leaderboard_id, "Kay - Test", "65.5", "{}", "1")
	
	# Get leaderboard entries
	await simpleboards.get_entries(leaderboard_id)

func _on_entries_got(entries):
	for entry in entries:
		print(entry)

func _on_entry_sent(entry):
	print(entry)
