class_name Player extends CharacterBody2D

const DBJI = preload("uid://2fcvfqjk0sif")

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var one_way_platform_check: RayCast2D = $OneWayPlatformCheck
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_area: AttackArea = $AttackArea


@export var move_speed : float = 150
@export var jump_velocity : float = 450
@export var max_fall_velocity : float = 500

#region /// State Machine Variable
var states : Array[ PlayerState ]
var current_state : PlayerState :
	get : return states.front()
var previous_state : PlayerState:
	get : return states[ 1 ]
#endregion

#region /// standard variables
var direction : Vector2 = Vector2.ZERO
@export var gravity : float = 980
var gravity_multiplier : float = 1
#endregion

func _ready() -> void:
	initialize_states()
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	change_state( current_state.handle_input( event ) )
	pass

func _process(_delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta ) )
	pass

func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	velocity.y = clampf( velocity.y, -10000, max_fall_velocity )
	move_and_slide()
	change_state( current_state.physics_process( _delta ) )
	pass
	
func initialize_states() -> void:
	states = []
	
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
	
	if states.size() == 0:
		return
		
	for state in states:
		state.init()
		
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	
	pass
	
func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
		
	states.push_front( new_state )
	current_state.enter()
	states.resize( 4 )
	$Label.text = current_state.name
	pass

func update_direction() -> void:
	var prev_direction : Vector2 = direction
	
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2( x_axis, y_axis )
	
	if prev_direction.x != direction.x:
		if direction.x <0:
			sprite.flip_h = true
			attack_area.rotation = 3.15
		if direction.x >0:
			sprite.flip_h = false
			attack_area.rotation = 0
	
	pass	
	
func add_debug_indicator( color : Color = Color.RED ) -> void:
	var d : Node2D = DBJI.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3 ).timeout
	d.queue_free()
	
	
	
	
	
	
	
	
