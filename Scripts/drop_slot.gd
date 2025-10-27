extends Button

var assigned_action: Global.CodeAction = Global.CodeAction.NULL
var is_hovering: bool = false;

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	if self.is_hovering and Global.holding_action != Global.CodeAction.NULL and !Global.is_dragging:
		self.assigned_action = Global.holding_action
		Global.holding_action = Global.CodeAction.NULL
		self.text = Global.CodeAction.keys()[self.assigned_action]

func _on_mouse_entered():
	self.is_hovering = true

func _on_mouse_exited():
	self.is_hovering = false
