@icon("../icons/AudioEventInstance2D.svg") class_name AudioEventInstance2D
extends AudioStreamPlayer2D 

## Node in charge of the actual playback of a 2D spatialized [AudioEvent].
##
## This node is a pooled [AudioStreamPlayer] from the [member AudioEventManager.pool_2D],
## and setup so that it automatically returns to its [NodePool] when finished playing.
## [br][br]
## See also: [AudioEventInstance3D], [AudioEventInstance].

var attachement: Node2D ## [Node2D] to follow. [code]null[/code] if the instance is stationary.

func _enter_tree() -> void:
	finished.connect(AudioEventManager.remove_instance.bind(self))
	play()

func _exit_tree() -> void:
	finished.disconnect(AudioEventManager.remove_instance)


## Used by the [AudioEventManager] to process the instance.
## If [member AudioEventInstance2D.attachement] has been set,
## the instance will follow the global position of the attachement.
func instance_process(delta: float) -> void:
	if is_instance_valid(attachement):
		position = attachement.global_position

