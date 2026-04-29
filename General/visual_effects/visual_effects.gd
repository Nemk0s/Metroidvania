extends Node

const DUST_EFFECT = preload("uid://cfk14ov3qu5km")
const HIT_PARTICLES = preload("uid://bo7mkc0osfd4f")

signal camera_shook( streanght : float )

func create_dust_effect( pos : Vector2 ) -> DustEffect:
	var dust : DustEffect = DUST_EFFECT.instantiate()
	add_child( dust )
	dust.global_position = pos
	return dust


func jump_dust( pos : Vector2 ) -> void:
	var dust: DustEffect = create_dust_effect( pos )
	dust.start( DustEffect.TYPE.JUMP )
	
	pass
	
func land_dust( pos : Vector2 ) -> void:
	var dust: DustEffect = create_dust_effect( pos )
	dust.start( DustEffect.TYPE.LAND) 
	
	pass
	
func hit_dust( pos : Vector2 ) -> void:
	var dust: DustEffect = create_dust_effect( pos )
	dust.start( DustEffect.TYPE.HIT)
	
	pass

func hit_particles( pos : Vector2, dir : Vector2, settings : HitParticleSettings ) -> void:
	var p : HitParticles = HIT_PARTICLES.instantiate()
	add_child( p )
	p.global_position = pos
	p.start( dir, settings )
	pass
	
	
func camera_shake( streanght : float = 1 ) -> void:
	camera_shook.emit( streanght )
	pass
