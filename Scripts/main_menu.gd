extends Control

@onready var first_name_box = $VBoxContainer/FirstNameLineEdit
@onready var last_name_box = $VBoxContainer/LastNameLineEdit

const CSV_PATH = "user://student_data.csv"

func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file("PATH/TO/SCENE")
	
	var first_name = first_name_box.text.strip_edges()
	var last_name = last_name_box.text.strip_edges()
	
	if first_name == "" or last_name == "":
		print("Please enter both names")
		return
	
	if len(last_name) > 1:
		print("Please only enter last initial")
		return
	
	var new_student = Student.new()
	new_student.set_first_name(first_name)
	new_student.set_last_name(last_name)
	
	if not FileAccess.file_exists(CSV_PATH):
		var new_file = FileAccess.open(CSV_PATH, FileAccess.WRITE)
		new_file.store_csv_line(["FirstName", "LastInitial"])
		new_file.close()
	
	var file = FileAccess.open(CSV_PATH, FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	
	if new_student.get_data_csv() in file_content:
		print("Student already exists")
		return
	
	file = FileAccess.open(CSV_PATH, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_csv_line(new_student.get_data())
	file.close()
	
	print("Saved student")
	pass
