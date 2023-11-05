@icon("../icons/AudioEventInstance.svg") class_name AudioEventInstance
extends AudioStreamPlayer

## Node in charge of the actual playback of a non-spatialized [AudioEvent].
##
## This node is a pooled [AudioStreamPlayer] from the [member AudioEventManager.pool_global],
## and setup so that it automatically returns to its [NodePool] when finished playing.
## [br][br]
## See also: [AudioEventInstance2D], [AudioEventInstance3D].

func _enter_tree() -> void:
	finished.connect(AudioEventManager.remove_instance.bind(self))
	play()

func _exit_tree() -> void:
	finished.disconnect(AudioEventManager.remove_instance)


## Used by the [AudioEventManager] to process the instance. 
## Has no effect on an [AudioEventInstance].
func instance_process(delta: float) -> void:
	pass

