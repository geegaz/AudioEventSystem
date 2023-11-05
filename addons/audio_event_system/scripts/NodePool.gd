@icon("../icons/NodePool.svg") class_name NodePool
extends Object

## A simple pooling system for nodes.
##
## Creating a [NodePool]:
## [codeblock]
## # Creates a pool of 100 Nodes
## var node_pool: NodePool = NodePool.new(Node.new(), 100)
## [/codeblock]
##
## [NodePool]s are useful when dealing with large amounts of fast-created nodes.
## Instead of instantiating a new node every time it's needed, the node pool instantiates
## a fixed number of nodes once and gets nodes from that "pool" using [method NodePool.get_pooled].
## Nodes should then be returned to the pool using [method NodePool.recycle_pooled].
## 
## [codeblock]
## var players_pool: NodePool = NodePool.new(AudioStreamPlayer.new(), 100)
##
## func play_sound(stream: AudioStream) -> AudioStreamPlayer:
##     var node: AudioStreamPlayer = players_pool.get_pooled()
##     node.stream = stream
##     # Connect the node to the recycle_pooled method of the node pool
##     # so that it gets put back into the pool after the sound finishes
##     node.finished.connect(players_pool.recycle_pooled.bind(node))
##     node.play()
##     
##     add_child(node)
##     return node
## [/codeblock]

var size: int = 0 ## Total number of nodes from the pool.
var available: = [] ## Available nodes in the pool.
var active: = [] ## Currently active nodes.

func _init(node: Node, size: int) -> void:
	for i in size:
		var new_node = node.duplicate()
		available.append(new_node)



## Gets a node from the pool.
## If there is no available node, the oldest active node is returned instead.
func get_pooled() -> Node:
	var node: Node
	if available.size() > 0:
		node = available.pop_back()
		active.append(node)
	else:
		node = active.pop_front()
		active.append(node)
		clear_parent(node)
	return node

## Returns a node to the pool.
## Only returns it if it's present in the active nodes.
func recycle_pooled(node: Node):
	# Check that the node is actually active
	var index: int = active.find(node)
	if index >= 0:
		active.remove_at(index)
		available.append(node)
		clear_parent(node)

## Removes a node from its parent, effectively removing from the [SceneTree] 
## and stopping its processing.
static func clear_parent(node: Node):
	var parent = node.get_parent()
	if parent:
		parent.remove_child(node)
