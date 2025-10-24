class_name Student extends Resource

@export var first_name: String
@export var last_name: String
@export var grade: int
@export var performance_history: Array

func _init(first_name: String, last_name: String, grade: int) -> void:
	self.first_name = first_name
	self.last_name = last_name
	self.grade = grade
	self.performance_history = []

func get_data() -> Array:
	var data = [
		self.first_name,
		self.last_name,
		self.grade,
		self.performance_history,
	]
	return data

func get_data_csv() -> String:
	var data = self.get_data()
	var csv_data = ""
	for i in range(len(data) - 1):
		csv_data += str(data[i]) + ','
	csv_data += str(data[-1])
	return csv_data
