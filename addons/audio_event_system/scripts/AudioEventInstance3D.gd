@icon("../icons/AudioEventInstance3D.svg") class_name AudioEventInstance3D
extends AudioStreamPlayer3D

## Node in charge of the actual playback of a 3D spatialized [AudioEvent].
##
## This node is a pooled [AudioStreamPlayer] from the [member AudioEventManager.pool_3D],
## and setup so that it automatically returns to its [NodePool] when finished playing.
## [br][br]
## See also: [AudioEventInstance2D], [AudioEventInstance].

var attachement: Node3D ## [Node3D] to follow. [code]null[/code] if the instance is stationary.

func _enter_tree() -> void:
	finished.connect(AudioEventManager.remove_instance.bind(self))
	play()

func _exit_tree() -> void:
	finished.disconnect(AudioEventManager.remove_instance)


## Used by the [AudioEventManager] to process the instance. 
## If [member AudioEventInstance3D.attachement] has been set, 
## the instance will follow the global position of the attachement.
func instance_process(delta: float) -> void:
	if is_instance_valid(attachement):
		position = attachement.global_position

