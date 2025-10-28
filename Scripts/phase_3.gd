extends Control

@onready var code_blocks_container = $VSplitContainer/BottomPanel/MarginContainer/HFlowContainer
@onready var code_slots_container = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
@onready var robot1 = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/SubViewportContainer/SubViewport/Robot
@onready var play_button = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/MarginContainer/HBoxContainer/PlayButton

var runtime: float = 0
var user_code: Array[Global.CodeAction] = []
var running = false
var code_index = 0

func _process(delta: float) -> void:
	runtime += delta

func _on_play_button_toggled(toggled_on: bool) -> void:
	running = toggled_on
	if toggled_on:
		code_index = 0
		play_button.text = "Pause"
	else:
		play_button.text = "Play"

func _on_code_timer_timeout() -> void:
	if running:
		_gather_user_code()
		if user_code.is_empty():
			return
		var action = user_code[code_index]
		print("Running: ", Global.CodeAction.keys()[action])
		robot1.run_action(action)
		code_index = (code_index + 1) % len(user_code)

func _gather_user_code():
	user_code.clear()
	for slot in code_slots_container.get_children():
		if slot.assigned_action != Global.CodeAction.NULL:
			user_code.append(slot.assigned_action)
