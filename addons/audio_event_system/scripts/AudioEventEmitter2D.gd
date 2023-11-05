@icon("../icons/AudioEventEmitter2D.svg") class_name AudioEventEmitter2D
extends Node2D

## Lightweight node used to play a 2D spatialized [AudioEvent] 
## similarly to an [AudioStreamPlayer2D].
##
## See also: [AudioEventEmitter3D], [AudioEventEmitter].

## Event played when calling [method AudioEventEmitter2D.play].
@export var emitter_event: AudioEvent
## Tells [method AudioEventEmitter2D.play] if the sound should follow the emitter.
@export var emitter_event_attached: bool = false

## Plays the current event set in [member AudioEventEmitter2D.emitter_event].
func play():
	play_event(emitter_event, emitter_event_attached)

## Plays the given event with spatialization.
func play_event(event: AudioEvent, attached: bool = false):
	if event:
		if attached:
			AudioEventManager.play_event_2D_attached(event, self)
		else:
			AudioEventManager.play_event_2D(event, global_position)
			
