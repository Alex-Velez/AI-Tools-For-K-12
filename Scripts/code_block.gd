extends Button

var shadow_scene = preload("res://Scenes/code_block_shadow.tscn")
@export var action_type: Global.CodeAction = Global.CodeAction.NULL

func _ready() -> void:
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	self.text = Global.CodeAction.keys()[action_type]
	if self.action_type in [Global.CodeAction.IsObstacleFront, Global.CodeAction.IsObstacleRight, Global.CodeAction.IsObstacleLeft, Global.CodeAction.IsSpaceTravelledFront, Global.CodeAction.IsSpaceTravelledRight, Global.CodeAction.IsSpaceTravelledLeft]:
		self.modulate = Color.PINK

func _on_button_down():
	Global.is_dragging = true
	Global.holding_code_block = shadow_scene.instantiate()
	get_tree().root.add_child(Global.holding_code_block)
	Global.holding_action = self.action_type

func _on_button_up():
	Global.is_dragging = false
	Global.holding_code_block.queue_free()
