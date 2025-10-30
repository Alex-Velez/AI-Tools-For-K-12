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
		
	var grade: int = -1
	match grade_dropdown.selected:
		1: grade = 5
		2: grade = 6
		3: grade = 7
		4: grade = 8
		5: grade = 9
		6: grade = 0
	
	var new_student = Student.new(first_name, last_name, grade)
	
	# check if student alreayd exists
	var file = FileAccess.open(Global.CSV_PATH, FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	
	for line in file_content.split("\n"):
		if !line.is_empty():
			var sline = line.split(",")
			if new_student.first_name == sline[0] and new_student.last_name == sline[1] and new_student.grade == int(sline[2]):
				print("Student already exists")
				return
	
	Global.current_student = new_student
	print("Cached student: first, last, grade")
	
	get_tree().change_scene_to_file("res://Scenes/welcome_screen.tscn")
	#get_tree().change_scene_to_file("res://Scenes/phase_3.tscn")
	pass
