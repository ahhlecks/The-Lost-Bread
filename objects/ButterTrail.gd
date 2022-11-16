extends KinematicBody2D


onready var sprite:Sprite = $Sprite
onready var bread = get_parent().get_parent().bread

var tween_decay:float = 1
var butter_decay:float = 2
var stretch:bool = false
var offset:Vector2 = Vector2(0,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	global_position = bread.global_position + offset
	yield(get_tree().create_timer(0.1),"timeout")
	look_at(get_parent().get_parent().bread.global_position + offset)
	stretch = true
	yield(get_tree().create_timer(butter_decay - tween_decay),"timeout")
	decay()

func decay() -> void:
	var tween = get_node("Tween")
	tween.interpolate_property(self, "modulate",
	Color("ffffff"), Color("00ffffff"), tween_decay,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween,"tween_completed")
	call_deferred("queue_free")
