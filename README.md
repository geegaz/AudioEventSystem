# Audio Event System
A flexible SFX plugin for Godot 4.x

## Introduction

The goal of this plugin is to give the most common features needed for sound effects (like randomized stream and randomized pitch) while also removing the need for multiple `AudioStreamPlayer`s to play different sounds. This plugin changes the audio workflow to bring it a bit closer to audio middlewares like [FMOD](https://fmod.com/), using `AudioEvent` resources to setup sound effects and an `AudioEventManager` to play them.

## Plugin structure
![a beautiful graph to explain the structure of the plugin, that may or may not have been made in ms-paint](/addons/audio_event_system/docs/addon_structure.png)

The plugin relies on a single resource, the `AudioEvent`. This resource contains the information needed to play a single sound effect:
- a list of `AudioStream`
- a minimum and maximum pitch
- a minimum and maximum volume

This resource is then used either directly through code by calling one of the `AudioEventManager`'s method, or by using an `AudioEventEmitter` which is a node dedicated to play an `AudioEvent` and designed as a replacement for an `AudioStreamPlayer` in the scene hierarchy.

Example of playing an `AudioEvent` directly with the `AudioEventManager`:
```
@export var event : AudioEvent

func play_event_directly() -> void:
    # Play the event without spatialization
    AudioEventManager.play_event(event)
```
Example of playing an `AudioEvent` through an `AudioEventEmitter`:
```
@onready var _Emitter := $AudioEventEmitter

func play_event_emitter() -> void:
    _Emitter.play()
```

Like `AudioStreamPlayer`s, `AudioEventEmitter`s come in 3 types:
- `AudioEventEmitter`, a non-spatialized emitter for global events
- `AudioEventEmitter2D`, an emitter spatialized in 2D
- `AudioEventEmitter3D`, an emitter spatialized in 3D
