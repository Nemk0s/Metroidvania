class_name PlayerStateAttack extends PlayerState

const KATANA_SWOOSH = preload("uid://dcmisg3qsonmf")

@export var combo_time_window : float = 0.3
@export var speed : float = 150
var timer : float = 0
var combo : int = 0




func init() -> void:
	pass

func enter() -> void:
	do_attack()
	player.animation_player.animation_finished.connect( _on_animation_finished )
	pass
func exit() -> void:
	timer = 0
	combo = 0
	player.animation_player.animation_finished.disconnect( _on_animation_finished )
	next_state = null
	pass
	
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("attack"):
		timer = combo_time_window
	if _event.is_action_pressed( "jump" ) and player.is_on_floor() == true:
		return jump
	return next_state

func process( _delta: float ) -> PlayerState:
	timer -= _delta
	return next_state
	
	
func physics_process( _delta: float ) -> PlayerState:
	player.velocity.x = player.direction.x * speed
	return null
	
func do_attack() -> void:
	if player.is_on_floor() == false:
		player.animation_player.play("Attack_air")
	else:
		var anim_name : String = "Attack_1"
		if combo == 0 :
			anim_name = "Attack_1"
		elif combo == 1:
			anim_name = "Attack_2"
		elif combo == 2:
			anim_name = "Attack_3"
		player.animation_player.play( anim_name )
	await get_tree().create_timer(0.1).timeout
	player.attack_area.activate(0.3)
	pass
	
func _end_attack() -> void:
	if timer > 0:
		combo = wrapi( combo + 1, 0, 3 )
		do_attack()
	else:
		if player.is_on_floor():
			next_state = idle
		else:
			next_state = fall
	pass
	
func _on_animation_finished( _anim_name : String ) -> void:
	_end_attack()
	pass
	

	
	
	
	
	
	
	
