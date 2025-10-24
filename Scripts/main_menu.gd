extends Control

@onready var first_name_box = $MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/FirstNameLineEdit
@onready var last_name_box = $MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/LastNameLineEdit
@onready var grade_dropdown = $MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/GradeOptionButton



func _on_start_button_pressed() -> void:
	var first_name = first_name_box.text.strip_edges()
	var last_name = last_name_box.text.strip_edges()
	
	if first_name == "" or last_name == "":
		print("Please enter both names")
		return
	
	if grade_dropdown.selected < 1:
		print("Please select a grade")
		return
	
	if len(last_name) > 1:
		print("Please only enter last initial")
		return
	
	var new_student = Student.new(first_name, last_name, grade_dropdown.selected + 5)
	
	Global.current_student = new_student
	print("Saved student")
	
	get_tree().change_scene_to_file("res://Scenes/welcome_screen.tscn")
	pass
