class_name Student extends Resource

@export var first_name: String = "Default Name"
@export var last_name: String = "L"

func set_first_name(name: String) -> void:
	self.first_name = name

func set_last_name(name: String) -> void:
	self.last_name = name

func get_data() -> Array:
	var data = [self.first_name, self.last_name]
	return data

func get_data_csv() -> String:
	var data = self.get_data()
	var csv_data = ""
	for i in range(len(data) - 1):
		csv_data += data[i] + ','
	csv_data += data[-1]
	return csv_data
