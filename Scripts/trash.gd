extends Area2D

@onready var sprite = $Sprite2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	sprite.frame = rng.randi_range(0, 676)

func _on_body_entered(_body: Node2D) -> void:
	self.queue_free()
