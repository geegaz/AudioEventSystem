@tool
extends EditorPlugin


## Plugin script


## Initialization of the plugin
func _enter_tree() -> void:
	add_autoload_singleton("AudioEventManager", "res://addons/audio_event_system/scripts/AudioEventManager.gd")


## Clean up of the plugin
func _exit_tree() -> void:
	remove_autoload_singleton("AudioEventManager")
