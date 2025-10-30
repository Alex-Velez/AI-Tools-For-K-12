extends Control

@onready var code_blocks_container = $VSplitContainer/BottomPanel/MarginContainer/HFlowContainer
@onready var code_slots_container = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
@onready var robot1 = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/VBoxContainer/SubViewportContainer/SubViewport/Robot
@onready var play_button = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/MarginContainer/HBoxContainer/PlayButton
@onready var timer = $Timer
@onready var slider = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/MarginContainer2/HSlider
@onready var trash_node_count: int = get_tree().get_nodes_in_group("Trash").size()
@onready var progress_bar = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/VBoxContainer/ProgressBar
@onready var drop_slots: Array = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer.get_children()

var runtime: float = 0
var user_code: Array[Global.CodeAction] = []
var running: bool = false
var code_index: int = 0
var trash_collected: int = 0
var clean_time: float = 0

func _ready() -> void:
	progress_bar.max_value = trash_node_count

func _process(delta: float) -> void:
	runtime += delta
	if progress_bar.ratio == 1.0:
		play_button.button_pressed = false
		print("Complete")
		_cache_student_data()
		Global.save_student_data()
		get_tree().change_scene_to_file("res://Scenes/phase_1_intro.tscn")

func _on_play_button_toggled(toggled_on: bool) -> void:
	running = toggled_on
	if toggled_on:
		code_index = 0

func _on_code_timer_timeout() -> void:
	if running:
		_gather_user_code()
		if user_code.is_empty():
			return
		drop_slots[code_index % len(drop_slots)].modulate = Color.AQUA
		drop_slots[(code_index - 1 + len(user_code)) % len(user_code)].modulate = Color.WHITE
		var action = user_code[code_index % len(user_code)]
		if action != null:
			robot1.run_action(action)
		code_index = (code_index + 1) % len(user_code)
		clean_time += timer.wait_time

func _gather_user_code():
	user_code.clear()
	for slot in code_slots_container.get_children():
		if slot.assigned_action != Global.CodeAction.NULL:
			user_code.append(slot.assigned_action)

func _on_trash_body_entered(_body: Node2D) -> void:
	trash_collected += 1
	progress_bar.value = trash_collected

func _cache_student_data():
	if Global.current_student == null:
		print("No student in cache!")
		return
	Global.current_student.phase_durations.append(runtime)
	Global.current_student.performance_history.append(progress_bar.ratio)
	Global.current_student.code_history["phase0"] = user_code
	print("Phase 0: Cached student: phasedur, perfhist, codehist")

func _on_speed_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		timer.wait_time = 0.03
	else:
		timer.wait_time = 0.5
