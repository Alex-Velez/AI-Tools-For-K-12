extends Panel

@onready var leaderboard_button = $VBoxContainer/MarginContainer/HBoxContainer/LeaderBoardButton
@onready var drop_slot_container = $VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
@onready var drop_slots: Array = drop_slot_container.get_children()
@onready var code_timer = $CodeTimer
@onready var performance_timer = $PerformanceTimer

@export var robot: RowdyRobot
@export var is_phase_3: bool
@export var default_code: Array[Global.CodeAction]
var is_code_running: bool = false
var code_block_index: int = 0
var user_code: Array[Global.CodeAction] = []
var clean_time: float = 0

func _ready() -> void:
	leaderboard_button.visible = is_phase_3
	if !default_code.is_empty():
		for i in range(default_code.size()):
			drop_slots[i].set_action(default_code[i])

func _on_code_timer_timeout() -> void:
	if is_code_running:
		_gather_user_code()
		if user_code.is_empty():
			return
		_set_drop_slot_highlight()
		var action = user_code[code_block_index % len(user_code)]
		if action != null:
			robot.run_action(action)
		code_block_index = (code_block_index + 1) % len(user_code)
		clean_time += code_timer.wait_time

func _on_play_button_toggled(toggled_on: bool) -> void:
	is_code_running = toggled_on
	if toggled_on:
		code_block_index = 0
		clean_time = 0
		robot.reset()
	if performance_timer.is_stopped():
		performance_timer.start()

func _on_speed_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		code_timer.wait_time = 0.03
	else:
		code_timer.wait_time = 0.5

func _on_leader_board_button_pressed() -> void:
	Global.save_student_data()
	#get_tree().change_scene_to_file(Paths.LEADERBOARD)

func _on_exit_button_pressed() -> void:
	print("Early Exit!")
	Global.save_student_data()
	get_tree().change_scene_to_file(Paths.MAIN_MENU)

func _set_drop_slot_highlight():
	drop_slots[code_block_index % len(drop_slots)].modulate = Color.AQUA
	drop_slots[(code_block_index - 1 + len(user_code)) % len(user_code)].modulate = Color.WHITE

func _gather_user_code():
	user_code.clear()
	for slot in drop_slot_container.get_children():
		if slot.assigned_action != Global.CodeAction.NULL:
			user_code.append(slot.assigned_action)

func _on_performance_timer_timeout() -> void:
	get_tree().change_scene_to_file(Paths.LEADERBOARD2)
