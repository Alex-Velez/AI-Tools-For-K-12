extends Control

@onready var drag_item1 = $ColorRect

var drag_item1_hovered = false;
var drag_item1_follow = false;

func _process(_delta: float) -> void:
	if drag_item1_hovered and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		var mouse_pos = get_viewport().get_mouse_position()
		
		var center = drag_item1.position + (drag_item1.size / 2)
		
		drag_item1.set_position(mouse_pos - (drag_item1.size / 2))

func _on_color_rect_mouse_entered() -> void:
	drag_item1_hovered = true
	print("Enter")
	pass

func _on_color_rect_mouse_exited() -> void:
	drag_item1_hovered = false
	print("Exit")
	pass
