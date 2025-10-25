extends Panel

var assigned_action: Global.CodeAction = Global.CodeAction.NULL

func can_drop_data(_pos, data):
	return "action" in data

func drop_data(_pos, data):
	assigned_action = data["action"]
	update_visual()

func update_visual():
	modulate = Color.WEB_GREEN
