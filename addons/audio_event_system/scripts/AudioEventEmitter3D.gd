@icon("../icons/AudioEventEmitter3D.svg") class_name AudioEventEmitter3D
extends Node3D

## Lightweight node used to play a 3D spatialized [AudioEvent] 
## similarly to an [AudioStreamPlayer3D].
##
## See also: [AudioEventEmitter2D], [AudioEventEmitter].

## Event played when calling [method AudioEventEmitter3D.play].
@export var emitter_event: AudioEvent
## Tells [method AudioEventEmitter3D.play] if the sound should follow the emitter.
@export var emitter_event_attached: bool = false

## Plays the current event set in [member AudioEventEmitter3D.emitter_event].
func play():
	play_event(emitter_event, emitter_event_attached)

## Plays the given event with spatialization.
func play_event(event: AudioEvent, attached: bool = false):
	if event:
		if attached:
			AudioEventManager.play_event_3D_attached(event, self)
		else:
			AudioEventManager.play_event_3D(event, global_position)
			
