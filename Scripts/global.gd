extends Node

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
var total_time_elapsed: float = 0.0
var is_tracking_time: bool = false

var trash_nodes: Array
var trash_node_count: int = -1
var trash_collected: int = 0

var student_list = []
var score = 0

func _ready():
	print("Global Autoload ready!")
	get_tree().set_auto_accept_quit(false)
	
	#ADDED FOR LEADERBOARD START
	#SilentWolf.configure({ "api_key": EnvPaths.API_KEY, "game_id": "RowdyRobo", "log_level": 1 })
	#SilentWolf.configure_scores({"open_scene_on_close": Paths.LEADERBOARD})

func leaderboard():
	for score in Global.score: 
		Global.student_list.append(current_student.first_name)
##END

func _process(delta: float) -> void:
	leaderboard()
	if is_tracking_time:
		Global.total_time_elapsed += delta
	if is_dragging and holding_code_block != null:
		holding_code_block.global_position = get_viewport().get_mouse_position() - Global.holding_code_block_offset

func cache_student_phase_data(_current_phase: String, phase_duration: float, performance: float, user_code: Array[Global.CodeAction]):
	print("Global: Chaching student...")
	if Global.current_student == null:
		print("No student in cache!")
		return
	
	Global.current_student.phase_durations.append(phase_duration)
	Global.current_student.performance_history.append(performance)
	Global.current_student.code_history.append(user_code)
	print("Global: Cached student - phasedur, perfhist, codehist")

func save_student_data():
	print("Global: Saving student...")
	if Global.current_student == null:
		print("No student in cache!")
		return
	
	if not FileAccess.file_exists(Paths.CSV_PATH):
		var new_file = FileAccess.open(Paths.CSV_PATH, FileAccess.WRITE)
		#new_file.store_csv_line(["FirstName", "LastInitial"])
		new_file.close()
	
	#var file = FileAccess.open(Paths.CSV_PATH, FileAccess.READ)
	#var file_content = file.get_as_text()
	#file.close()
	#if new_student.get_data_csv() in file_content:
		#print("Student already exists")
		#return
	
	var file = FileAccess.open(Paths.CSV_PATH, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_csv_line(Global.current_student.get_data())
	file.close()
	
	print("Global: Saved Student data!")

func count_trash():
	trash_nodes = get_tree().get_nodes_in_group("Trash")
	Global.trash_node_count = trash_nodes.size()
	Global.trash_collected = 0

func reset_trash():
	Global.trash_collected = 0
	for trash in trash_nodes:
		trash.make_exist()

func _on_close_requested():
	print("Early Exit!")
	Global.save_student_data()
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Early Exit!")
		Global.save_student_data()
		get_tree().quit()
