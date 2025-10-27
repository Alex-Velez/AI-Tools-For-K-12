extends CharacterBody2D

var grid_cell_size = 16
var direction: Vector2 = Vector2(0, 1)
var rng = RandomNumberGenerator.new()
var current_conditional = false

func run_action(action: Global.CodeAction):
	match action:
		Global.CodeAction.MoveForward:
			_move_forward()
		Global.CodeAction.MoveBackward:
			_move_backward()
		Global.CodeAction.MoveRandom:
			if rng.randf() > 0.5:
				_move_forward()
			else:
				_move_backward()
		Global.CodeAction.TurnRight:
			_turn_right()
		Global.CodeAction.TurnLeft:
			_turn_left()
		Global.CodeAction.Turn180:
			_turn_right()
			_turn_right()
		Global.CodeAction.TurnRandom:
			for i in range(rng.randi_range(0, 3)):
				_turn_right()
		Global.CodeAction.IsObstacleFront:
			_is_obstacle_front()

func _move_forward():
	self.position += direction * grid_cell_size

func _move_backward():
	self.position -= direction * grid_cell_size

func _turn_right(): 
	self.direction = self.direction.rotated(deg_to_rad(-90))
	$Sprite2D.rotate(deg_to_rad(-90))

func _turn_left():
	self.direction = self.direction.rotated(deg_to_rad(90))
	$Sprite2D.rotate(deg_to_rad(90))

func _is_obstacle_front():
	pass
