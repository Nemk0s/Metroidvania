extends Node2D

#@export var particles : Array[ HitParticleSetting ]
@export var base_wobble_angle : float = 4.0
@export var wobble_speed : float = 0.1

var wobble_count : int = 0
var tween : Tween

@onready var damage_area: DamageArea = $DamageArea
@onready var body: Sprite2D = $Body


func _ready() -> void:
	damage_area.damage_taken.connect( _on_damage_taken )
	pass



func _on_damage_taken( attack_area : AttackArea ) -> void:
	var dir : float = 1.0
	if attack_area.global_position.x > global_position.x:
		dir = -1
	print("HIT")
