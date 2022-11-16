extends Node

var bread_walk = preload("res://assets/sounds/bread_walk.wav")
var bread_walk2 = preload("res://assets/sounds/bread_walk2.wav")
var disable_walk_sound:bool = true




# Player Vars

var current_type = "plain_bread"
var sentience:bool = true
var chewiness:float = .4
var toastiness:float = .1
var butteriness:float = .0
var sweetness:float = .0
var bitterness:float = .0
var saltiness:float = .0
var temperature:float = .4
var meatiness:float = .0

var freshness:float = 1
var speediness:float = 1

var type_history:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
