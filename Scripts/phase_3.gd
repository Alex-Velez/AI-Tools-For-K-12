extends Control

@onready var code_blocks_container = $VSplitContainer/BottomPanel/MarginContainer/HFlowContainer
@onready var code_slots_container = $VSplitContainer/TopPanel/HSplitContainer/RightPanel/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
@onready var robot1 = $VSplitContainer/TopPanel/HSplitContainer/LeftPanel/HBoxContainer/SubViewportContainer/SubViewport/Robot

var user_code: Array[Global.CodeAction] = []

func gather_user_code():
	user_code.clear()
	for slot in code_slots_container.get_children():
		if slot.assigned_action != Global.CodeAction.NULL:
			user_code.append(slot.assigned_action)

func _on_play_button_pressed() -> void:
	gather_user_code()
	await _run_user_code()

func _run_user_code():
	for action in user_code:
		#highlight_block(action)
		print("Running: ", Global.CodeAction.keys()[action])
		await robot1.run_action(action)
		await get_tree().create_timer(0.5).timeout
	#reset_highlights()
