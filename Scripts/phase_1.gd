extends Control
@onready var simpleboards = $SimpleBoardsApi
@onready var trash_node_count: int = get_tree().get_nodes_in_group("Trash").size()
@onready var progress_bar = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/VBoxContainer/ProgressBar
@onready var right_panel = $VSplitContainer/TopPanel/HSplitContainer/RightPanel
const leaderboard_id = "b424453d-081b-4666-0528-08de1bc660ae"
var phase_duration: float = 0
var trash_collected: int = 0

func _ready() -> void:
	Global.count_trash()
	progress_bar.max_value = trash_node_count
	DialogueManager.show_dialogue_balloon(load(Paths.PHASE1_DIALOGUE))
	progress_bar.value_changed.connect(_on_progress_value_changed)

func _on_progress_value_changed(new_value):
	if new_value >= 99:
		#print("top line")
		right_panel.goto_next_scene = true
	
func _process(delta: float) -> void:
	phase_duration += delta
	progress_bar.value = Global.trash_collected
	if right_panel.goto_next_scene or progress_bar.ratio >= .99:
		print("Phase1: Complete")
		Global.cache_student_phase_data("phase1", phase_duration, progress_bar.ratio, right_panel.user_code)
		#await simpleboards.send_score_without_id(leaderboard_id, Global.current_student.first_name, 88, "") #Global.current_student.phase1_performance_history
		#get_tree().change_scene_to_file(Paths.LEADERBOARD)
		get_tree().change_scene_to_file(Paths.PHASE2)
