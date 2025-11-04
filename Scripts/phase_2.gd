extends Control

@onready var trash_node_count: int = get_tree().get_nodes_in_group("Trash").size()
@onready var progress_bar = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/VBoxContainer/ProgressBar
@onready var right_panel = $VSplitContainer/TopPanel/HSplitContainer/RightPanel

var phase_duration: float = 0
var trash_collected: int = 0

func _ready() -> void:
	progress_bar.max_value = trash_node_count
	DialogueManager.show_dialogue_balloon(load(Paths.PHASE2_DIALOGUE))

func _process(delta: float) -> void:
	phase_duration += delta
	if progress_bar.ratio == 1.0:
		print("Phase2: Complete")
		Global.cache_student_phase_data("phase2", phase_duration, progress_bar.ratio, right_panel.user_code)
		get_tree().change_scene_to_file(Paths.PHASE3)

func _on_trash_body_entered(_body: Node2D) -> void:
	trash_collected += 1
	progress_bar.value = trash_collected
