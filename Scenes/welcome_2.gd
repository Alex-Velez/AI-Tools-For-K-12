extends Control
@onready var dialogue_manager = DialogueManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_manager.dialogue_ended.connect(_on_dialogue_finished)
	
	DialogueManager.show_dialogue_balloon(load(Paths.WELCOME_DIALOGUE))
	
	pass # Replace with function body.

func _on_dialogue_finished():
	get_tree().change_scene(Paths.PHASE0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
