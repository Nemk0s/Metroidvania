class_name PlayerCamera extends Camera2D

var shake_streangh : float = 0.0
@export var shake_decay_rate : float = 5.0
@export var max_shake_offset : float = 10.0

func _ready() -> void:
	VisualEffects.camera_shook.connect( _apply_shake )
	pass



func _process(delta: float) -> void:
	offset = Vector2( 
		randf_range( -shake_streangh, shake_streangh ),
		randf_range( -shake_streangh, shake_streangh )
		)
	shake_streangh = lerp( shake_streangh, 0.0, shake_decay_rate * delta )
	pass


func _apply_shake( streangh : float ) -> void:
	shake_streangh = min( streangh, max_shake_offset )
	pass
