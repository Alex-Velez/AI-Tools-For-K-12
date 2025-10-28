class_name Student extends Resource

var first_name: String
var last_name: String
var grade: int
var phase_durations: Array[int]
var performance_history: Array
var code_history: Array[Global.CodeAction]

func _init(f_name: String, l_name: String, s_grade: int) -> void:
	self.first_name = f_name
	self.last_name = l_name
	self.grade = s_grade
	self.phase_durations = [0, 0, 0, 0]
	self.performance_history = []
	self.code_history = []

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
