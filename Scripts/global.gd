extends Node

const CSV_PATH = "user://student_data.csv"

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

var current_student: Student = null;
var is_dragging: bool = false
var holding_code_block = null
var holding_code_block_offset: Vector2 = Vector2.ZERO
var holding_action: CodeAction = CodeAction.NULL

var student_list = []
var score = 0

func _ready():
	print("Global Autoload ready!")
	#ADDED FOR LEADERBOARD START
	SilentWolf.configure({ "api_key": "TblPt5B7K7xhsmuD2FPL6FdzF4mPUJmk551bTf70", "game_id": "RowdyRobo", "log_level": 1 })

	SilentWolf.configure_scores({
	"open_scene_on_close": "res://Scenes/leaderboard.tscn"
  })

func leaderboard():
	for score in Global.score: 
		Global.student_list.append(current_student.first_name)
##END

func _process(_delta: float) -> void:
	leaderboard()
	if is_dragging:
		holding_code_block.global_position = get_viewport().get_mouse_position() - Global.holding_code_block_offset



func save_student_data():
	if not FileAccess.file_exists(Global.CSV_PATH):
		var new_file = FileAccess.open(Global.CSV_PATH, FileAccess.WRITE)
		#new_file.store_csv_line(["FirstName", "LastInitial"])
		new_file.close()
	
	#var file = FileAccess.open(Global.CSV_PATH, FileAccess.READ)
	#var file_content = file.get_as_text()
	#file.close()
	#if new_student.get_data_csv() in file_content:
		#print("Student already exists")
		#return
	
	var file = FileAccess.open(Global.CSV_PATH, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_csv_line(Global.current_student.get_data())
	file.close()
	
	print("Saved Student data")
