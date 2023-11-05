@icon("../icons/AudioEvent.svg") class_name AudioEvent
extends Resource

## Resource containing information on how to play a sound.
##
##

@export var audio_bus: String = "Master" ## Audio bus used by the event.

@export var streams: Array[AudioStream] ## List of sounds that can be played by the event.

@export_range(0.0, 2.0) var pitch_min: = 1.0 ## Minimum pitch of the sound.
@export_range(0.0, 2.0) var pitch_max: = 1.0 ## Maximum pitch of the sound.

@export_range(0.0, 2.0) var volume_min: = 1.0 ## Minimum volume of the sound (linear).
@export_range(0.0, 2.0) var volume_max: = 1.0 ## Maximum volume of the sound (linear).

# TODO: change plugin structure to allow looping and fade-in/fade-out
#export var looping: bool = false
#
#export var fade_in: bool = false
#export var fade_in_duration: float = 0.1
#export(float, EASE) var fade_in_curve: float = 0.5
#
#export var fade_out: bool = false
#export var fade_out_duration: float = 0.1
#export(float, EASE) var fade_out_curve: float = 0.5

var last_stream: int ## Stores the last value returned by [method AudioEvent.randomize_stream].
var last_pitch: float ## Stores the last value returned by [method AudioEvent.randomize_pitch].
var last_volume: float ## Stores the last value returned by [method AudioEvent.randomize_volume].

## Returns a random index of the [member AudioEvent.streams] list.
func randomize_stream()->int:
	last_stream = randi() % streams.size()
	return last_stream

## Returns a random pitch between [member AudioEvent.pitch_min] and [member AudioEvent.pitch_max].
func randomize_pitch()->float:
	last_pitch = lerp(pitch_min, pitch_max, randf())
	return last_pitch

## Returns a random pitch between [member AudioEvent.volume_min] and [member AudioEvent.volume_max] (linear).
func randomize_volume()->float:
	last_volume = linear_to_db(lerp(volume_min, volume_max, randf()))
	return last_volume
