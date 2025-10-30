extends Control


func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(load("res://Scripts/phase1.dialogue"))

	
	pass # Replace with function body.
	

func _on_dialogue_ended(_resource: DialogueResource) -> void:
	
	print("Dialogue ended! Changing scene...")
	get_tree().change_scene_to_file("res://Scenes/phase_1.tscn")

	pass
	#get_tree().change_scene_to_file("res://Scenes/phase_0.tscn")
