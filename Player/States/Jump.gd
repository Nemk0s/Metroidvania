@icon("res://Player/States/state.svg")
class_name PlayerStateJump
extends PlayerState





func init() -> void:
	pass
	
	
	
func enter() -> void:
	#player.add_debug_indicator( Color.GREEN )
	player.animation_player.play("Jump")
	player.velocity.y = -player.jump_velocity
	
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state( fall )
		pass
		
	
	pass
	
	
func exit() -> void:
	#player.add_debug_indicator( Color.YELLOW )
	pass
	
	
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_released( "jump" ):
		return fall
	return next_state
	
func process( _delta: float ) -> PlayerState:
	return next_state

func physics_process( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
