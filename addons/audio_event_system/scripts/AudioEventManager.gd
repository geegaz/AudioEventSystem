@icon("../icon/AudioEventManager.gd")
extends Node

## The core of the Audio Event System plugin.
## 

@export var pool_size_global: int = 50 ## Number of global sounds that can play simultaneously
@export var pool_size_2D: int = 100 ## Number of 2D sounds that can play simultaneously
@export var pool_size_3D: int = 100 ## Number of 3D sounds that can play simultaneously

## Pool of [AudioEventInstance] used for global sounds
var pool_global: NodePool = NodePool.new(AudioEventInstance.new(), pool_size_global)
## Pool of [AudioEventInstance2D] used for 2D sounds
var pool_2D: NodePool = NodePool.new(AudioEventInstance2D.new(), pool_size_2D)
## Pool of [AudioEventInstance3D] used for 3D sounds
var pool_3D: NodePool = NodePool.new(AudioEventInstance3D.new(), pool_size_3D)

func _ready() -> void:
	pass
#	pool_global = NodePool.new(AudioEventInstance.new(), pool_size_global)
#	pool_2D = NodePool.new(AudioEventInstance2D.new(), pool_size_2D)
#	pool_3D = NodePool.new(AudioEventInstance3D.new(), pool_size_3D)

func _process(delta: float) -> void:
	for instance in pool_global.active:
		instance.instance_process(delta)
	for instance in pool_2D.active:
		instance.instance_process(delta)
	for instance in pool_3D.active:
		instance.instance_process(delta)


## Removes an [AudioEventInstance], [AudioEventInstance2D] or [AudioEventInstance3D]
## from the scene tree and puts it back into the associated pool.
## Called automatically by instances when they have finished playing.
func remove_instance(instance: Node) -> void:
	if instance is AudioStreamPlayer3D:
		pool_3D.recycle_pooled(instance)
	elif instance is AudioStreamPlayer2D:
		pool_2D.recycle_pooled(instance)
	else:
		pool_global.recycle_pooled(instance)

## Removes all currently playing instances, effectively stopping all sounds.
func remove_all_instances() -> void:
	for instance in pool_global.active:
		pool_global.recycle_pooled(instance)
	for instance in pool_2D.active:
		pool_global.recycle_pooled(instance)
	for instance in pool_3D.active:
		pool_global.recycle_pooled(instance)

## Given an instance and an [AudioEvent], sets all the properties of the instance
## from the event.
func setup_instance(instance: Node, event: AudioEvent) -> void:
	if is_instance_valid(instance) and event:
		# Setup the values
		instance.stream = event.streams[event.randomize_stream()]
		instance.pitch_scale = event.randomize_pitch()
		instance.volume_db = event.randomize_volume()
		instance.bus = event.audio_bus
	else:
		if not is_instance_valid(instance):
			printerr("Given instance is invalid or null")
		if not event:
			printerr("Given event is null")


## Plays the given [AudioEvent] without spatialization.
func play_event(event: AudioEvent)->AudioEventInstance:
	var instance: AudioEventInstance = pool_global.get_pooled()
	
	setup_instance(instance, event)
	add_child(instance)
	return instance

## Plays the given [AudioEvent] spatialized at the given position in 2D.
func play_event_2D(event: AudioEvent, position: Vector2)->AudioEventInstance2D:
	var instance: AudioEventInstance2D = pool_2D.get_pooled()
	instance.position = position
	
	setup_instance(instance, event)
	add_child(instance)
	return instance

## Plays the given [AudioEvent] spatialized and following the given [Node2D].
func play_event_2D_attached(event: AudioEvent, node: Node2D)->AudioEventInstance2D:
	var instance: AudioEventInstance2D = pool_2D.get_pooled()
	instance.attachement = node
	
	setup_instance(instance, event)
	add_child(instance)
	return instance

## Plays the given [AudioEvent] spatialized at the given position in 3D.
func play_event_3D(event: AudioEvent, position: Vector3)->AudioEventInstance3D:
	var instance: AudioEventInstance3D = pool_3D.get_pooled()
	instance.position = position
	
	setup_instance(instance, event)
	add_child(instance)
	return instance

## Plays the given [AudioEvent] spatialized and following the given [Node3D].
func play_event_3D_attached(event: AudioEvent, node: Node3D)->AudioEventInstance3D:
	var instance: AudioEventInstance3D = pool_3D.get_pooled()
	instance.attachement = node
	
	setup_instance(instance, event)
	add_child(instance)
	return instance
