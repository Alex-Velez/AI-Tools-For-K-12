extends Node

const CSV_PATH = "user://student_data.csv"

var current_student: Student = null;

var is_dragging = false

enum CodeAction {
	NULL,
	MoveForward,
	MoveBackward,
	MoveRandom,
	TurnRight,
	TurnLeft,
	Turn180,
	TurnRandom,
	IsObstacleFront,
	IsObstacleRight,
	IsObstacleLeft,
	IsSpaceTravelledFront,
	IsSpaceTravelledRight,
	IsSpaceTravelledLeft,
}

func _ready():
	print("Global Autoload ready!")

func save_data(data: Array):
	if not FileAccess.file_exists(Global.CSV_PATH):
		var new_file = FileAccess.open(Global.CSV_PATH, FileAccess.WRITE)
		new_file.store_csv_line(["FirstName", "LastInitial"])
		new_file.close()
	
	#var file = FileAccess.open(Global.CSV_PATH, FileAccess.READ)
	#var file_content = file.get_as_text()
	#file.close()
	#if new_student.get_data_csv() in file_content:
		#print("Student already exists")
		#return
	
	var file = FileAccess.open(Global.CSV_PATH, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_csv_line(data)
	file.close()
	
	print("Saved data")
