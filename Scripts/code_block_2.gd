extends Button

var shadow_scene = preload("res://Scenes/code_block_shadow.tscn")
@export var action_type: Global.CodeAction = Global.CodeAction.NULL
var is_dragging: bool =  false
var offset: Vector2
var code_block_shadow = null

func _ready() -> void:
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _process(_delta: float) -> void:
	if is_dragging:
		code_block_shadow.global_position = get_global_mouse_position()

func _on_button_down():
	is_dragging = true
	offset = get_global_mouse_position() - global_position
	code_block_shadow = shadow_scene.instantiate()
	get_tree().root.add_child(code_block_shadow)
	print("Dragging")

func _on_button_up():
	is_dragging = false
	code_block_shadow.queue_free()
	print("Static")
