@icon("../icons/AudioEventEmitter.svg") class_name AudioEventEmitter
extends Node

## Lightweight node used to play a non-spatialized [AudioEvent] 
## similarly to an [AudioStreamPlayer].
##
## See also: [AudioEventEmitter2D], [AudioEventEmitter3D].

@export var emitter_event: AudioEvent ## Event played when calling [method AudioEventEmitter.play]

## Plays the current event set in [member AudioEventEmitter.emitter_event].
func play():
	play_event(emitter_event)

## Plays the given event without spatialization.
func play_event(event: AudioEvent):
	if event:
		AudioEventManager.play_event(event)
			
