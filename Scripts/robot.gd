extends CharacterBody2D

@onready var ray_forward = $ForwardRayCast2D
@onready var ray_backward = $BackwardRayCast2D
@onready var ray_right = $RightRayCast2D
@onready var ray_left = $LeftRayCast2D

var grid_cell_size = 16
var grid_position = Vector2(0, 0)
var direction: Vector2 = Vector2(0, 1)
var rng = RandomNumberGenerator.new()
var current_conditional = false
var conditional_just_played = false

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
			_turn_180()
		Global.CodeAction.TurnRandom:
			for i in range(rng.randi_range(0, 3)):
				_turn_right()
		Global.CodeAction.IsObstacleFront:
			_is_obstacle_front()
		Global.CodeAction.IsObstacleRight:
			_is_obstacle_right()
		Global.CodeAction.IsObstacleLeft:
			_is_obstacle_left()

func _reset_conditional():
	self.current_conditional = false
	self.conditional_just_played = false

func _move_forward():
	if self.conditional_just_played and !self.current_conditional:
		_reset_conditional()
		return
	if !ray_forward.is_colliding():
		self.position += direction * grid_cell_size
		self.grid_position += direction
	_reset_conditional()

func _move_backward():
	if self.conditional_just_played and !self.current_conditional:
		_reset_conditional()
		return
	if !ray_backward.is_colliding():
		self.position -= direction * grid_cell_size
		self.grid_position -= direction
	_reset_conditional()

func _turn_right():
	if self.conditional_just_played and !self.current_conditional:
		_reset_conditional()
		return
	self.direction = self.direction.rotated(deg_to_rad(-90))
	self.rotate(deg_to_rad(-90))
	_reset_conditional()

func _turn_left():
	if self.conditional_just_played and !self.current_conditional:
		_reset_conditional()
		return
	self.direction = self.direction.rotated(deg_to_rad(90))
	self.rotate(deg_to_rad(90))
	_reset_conditional()

func _turn_180():
	if self.conditional_just_played and !self.current_conditional:
		_reset_conditional()
		return
	self.direction = self.direction.rotated(deg_to_rad(180))
	self.rotate(deg_to_rad(180))
	_reset_conditional()

func _is_obstacle_front():
	current_conditional = ray_forward.is_colliding()
	self.conditional_just_played = true

func _is_obstacle_back():
	current_conditional = ray_backward.is_colliding()
	self.conditional_just_played = true

func _is_obstacle_right():
	current_conditional = ray_right.is_colliding()
	self.conditional_just_played = true

func _is_obstacle_left():
	current_conditional = ray_left.is_colliding()
	self.conditional_just_played = true
