extends StaticBody2D

func _ready() -> void:
	modulate = Color(Color.MAGENTA)
	
func _process(_delta: float) -> void:
	visible = Global.is_dragging
