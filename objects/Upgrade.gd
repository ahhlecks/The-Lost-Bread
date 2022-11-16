extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var upgrade:String
var stats:Dictionary
var ready:bool = false
var disabled:bool = false
var current_body:KinematicBody2D

onready var popup = $Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	if ready and !disabled:
		if Input.is_action_just_pressed("ui_accept"):
			var keys:Array = stats.keys()
			var values:Array = stats.values()
			for stat in stats.size():
				current_body.set(keys[stat], current_body.get(keys[stat]) + values[stat])
				current_body.set(keys[stat], clamp(current_body.get(keys[stat]),0,1))
				current_body.update_vars()
				call_deferred("queue_free")

func setup(upgrade_name) -> void:
	upgrade = upgrade_name
	texture = load("res://assets/ui/" + upgrade_name + ".png")
	$Panel.get_child(0).text = upgrade.capitalize()
	match upgrade_name:
		"toaster":
			stats = {
				"toastiness" : .25,
				"temperature" : .2,
				"chewiness" : -.25
				}
		"microwave":
			stats = {
				"temperature" : .25,
				"chewiness" : .2
				}
		"butter":
			stats = {
				"butteriness" : .25,
				"saltiness" : .05
				}
		"sugar":
			stats = {
				"sweetness" : .25,
				}
		"salt":
			stats = {
				"saltiness" : .25,
				}
		"meat":
			stats = {
				"meatiness" : .25,
				"saltiness" : .05,
				}
		"refrigerator":
			stats = {
				"temperature" : -.1,
				"toastiness" : -.25,
				"chewiness" : .1
				}
		"freezer":
			stats = {
				"temperature" : -.25,
				"freshness" : .2,
				"chewiness" : -.05
				}
		"cheese":
			stats = {
				"saltiness" : .15,
				"chewiness" : .20,
				"butteriness" : .15
				}
		"arugula":
			stats = {
				"saltiness" : -.2,
				"sweetness" : -.2,
				}
		"spatula":
			stats = {
				"saltiness" : -.05,
				"sweetness" : -.05,
				"butteriness" : -.2,
				"freshness" : .15
				}

func print_stat(stat:float) -> String:
	var output:String = ""
	var calculated_stat = stat
	if calculated_stat > 0:
		while calculated_stat > 0.01:
			calculated_stat -= .05
			output += "+"
	else:
		while calculated_stat < -0.01:
			calculated_stat += .05
			output += "-"
	return output

func _on_Area2D_body_entered(body):
	current_body = body
	ready = true
	var keys:Array = stats.keys()
	var values:Array = stats.values()
	popup.visible = true
	popup.get_child(1).clear()
	
	for stat in stats.size():
#		body.set(keys[stat], body.get(keys[stat]) + values[stat])
#		body.set(keys[stat], clamp(body.get(keys[stat]),0,1))
		popup.get_child(1).add_text(keys[stat].capitalize() + " " + print_stat(values[stat]) + "\n")
#	call_deferred("queue_free")


# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	current_body = null
	ready = false
	popup.visible = false
	
