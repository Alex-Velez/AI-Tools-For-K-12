class_name Student extends Resource

var first_name: String = "null"
var last_name: String = "null"
var grade: int = -1
var phase_durations: Array[float]
#
var phase0_duration: float = -1
var phase1_duration: float = -1
var phase2_duration: float = -1
var phase3_duration: float = -1 
var performance_history: Array[float]
#
var phase0_performance_history: Array[float] = []
var phase1_performance_history: Array[float] = []
var phase2_performance_history: Array[float] = []
var phase3_performance_history: Array[float] = [] 
var code_history: Dictionary[String, Array]
#
var phase0_code_history: Array[Array] = []
var phase1_code_history: Array[Array] = []
var phase2_code_history: Array[Array] = []
var phase3_code_history: Array[Array] = []

func _init(f_name: String, l_name: String, s_grade: int) -> void:
	self.first_name = f_name
	self.last_name = l_name
	self.grade = s_grade
	self.phase_durations = []
	self.performance_history = []
	self.code_history = {}

func get_data() -> Array:
	var data = [
		self.first_name,
		self.last_name,
		self.grade,
		self.phase_durations,
		self.performance_history,
		self.code_history,
	]
	return data

#func get_data_csv() -> String:
	#var data = self.get_data()
	#var csv_data = ""
	#for i in range(len(data) - 1):
		#csv_data += str(data[i]) + ','
	#csv_data += str(data[-1])
	#return csv_data
