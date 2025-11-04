class_name DropSlot extends Button

var assigned_action: Global.CodeAction = Global.CodeAction.NULL
var is_hovering: bool = false;

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	if self.is_hovering:
		if Input.is_action_pressed("right_mouse_click"):
			self.clear_action()
		elif Global.holding_action != Global.CodeAction.NULL and !Global.is_dragging:
			self.set_action(Global.holding_action)
			Global.holding_action = Global.CodeAction.NULL
			
func _on_mouse_entered():
	self.is_hovering = true

func _on_mouse_exited():
	self.is_hovering = false

func clear_action():
	self.assigned_action = Global.CodeAction.NULL
	self.text = " "

func set_action(action: Global.CodeAction):
	self.assigned_action = action
	self.text = Global.CodeAction.keys()[self.assigned_action]
