@icon("../icons/NodePool.svg") class_name ScenePool
extends NodePool

## A variation of [NodePool] using a [PackedScene] to create the pool.
##
## Creating a [ScenePool]:
## [codeblock]
## @export var scene: PackedScene = preload("res://path/to/scene.tscn")
## 
## # Creates a pool of 100 instantiated scenes
## var scene_pool: ScenePool = ScenePool.new(scene, 100)
## 
## # Can also be used as a regular NodePool
## var node_pool: NodePool = ScenePool.new(scene, 100)
## [/codeblock]

func _init(scene: PackedScene, size: int) -> void:
	for i in size:
		var new_scene = scene.instantiate()
		available.append(new_scene)
