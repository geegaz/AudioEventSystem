extends Node3D

@export var test_event: AudioEvent

var emitter_animations: = {}

func play_emitter(emitter: AudioEventEmitter3D, display: Node3D)->void:
	emitter.play()
	if emitter_animations.has(emitter):
		emitter_animations[emitter].kill()
	var tween: = create_tween()
	tween.set_parallel(true)
	tween.tween_property(display, "scale", Vector3.ONE * 1.5, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain().tween_property(display, "scale", Vector3.ONE, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	emitter_animations[emitter] = tween
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		AudioEventManager.play_event(test_event)
	
	if event.is_action_pressed("ui_left"):
		play_emitter($LeftEmitter, $LeftEmitter/Sprite3D)
	if event.is_action_pressed("ui_right"):
		play_emitter($RightEmitter, $RightEmitter/Sprite3D)
	
