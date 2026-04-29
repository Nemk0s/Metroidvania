extends Node

enum REVERB_TYPE { NONE, SMALL, MEDIUM, LARGE }


@export var ui_focus_audio : AudioStream
@export var ui_select_audio : AudioStream
@export var ui_cancel_audio : AudioStream
@export var ui_success_audio : AudioStream
@export var ui_error_audio : AudioStream

var current_track : int = 0
var music_tweens : Array[ Tween ]
var ui_audio_player : AudioStreamPlaybackPolyphonic

@onready var music_1: AudioStreamPlayer = %"Music 1"
@onready var music_2: AudioStreamPlayer = %"Music 2"
@onready var ui: AudioStreamPlayer = %UI



func _ready() -> void:
	
	pass
