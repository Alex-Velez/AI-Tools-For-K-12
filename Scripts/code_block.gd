extends Node2D

@export var block_type: BlockType = BlockType.NULL;

var is_draggable = false
var is_inside_droppable = false
var body_reference
var offset: Vector2
var initial_position: Vector2
var text: String

const ANIMATION_SPEED = 0.2

enum BlockType {
	NULL,
	And,
	Or,
	MoveForward,
	MoveBackward,
	MoveRandom,
	TurnRight,
	TurnLeft,
	Turn180,
	TurnRandom,
	IsObstacleFront,
	IsObstacleRight,
	IsObstacleLeft,
	IsSpaceTravelledFront,
	IsSpaceTravelledRight,
	IsSpaceTravelledLeft,
}

func _ready() -> void:
	match self.block_type:
		BlockType.And:
			pass
	pass

func _process(_delta: float) -> void:
	if is_draggable:
		if Input.is_action_just_pressed("mouse_click"):
			initial_position = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("mouse_click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("mouse_click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_droppable:
				tween.tween_property(
					self,
					"position",
					body_reference.position,
					ANIMATION_SPEED,
				).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(
					self,
					"global_position",
					initial_position,
					ANIMATION_SPEED,
				).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		is_draggable = true
		scale = Vector2(1.05, 1.05)

func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:
		is_draggable = false
		scale = Vector2(1, 1)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body_reference != null and body.position == body_reference.position:
		return
	if body.is_in_group("Droppable"):
		is_inside_droppable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_reference = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body_reference != null and body.position == body_reference.position:
		return
	if body.is_in_group("Droppable"):
		is_inside_droppable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	
