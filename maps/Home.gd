extends Node2D

onready var camera:Camera2D = $Camera
onready var trails = $Trails
onready var bread = $Bread
var active_room:String
var previous_room:String
var test:TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	previous_room = ""
	active_room = "StartRoom"
# warning-ignore:return_value_discarded
	$Bread.connect("change_room",self,"change_room")
# warning-ignore:return_value_discarded
	$Bread.connect("enter_camera",self,"enter_camera")
# warning-ignore:return_value_discarded
	$Bread.connect("exit_camera",self,"exit_camera")


func change_room(area) -> void:
	if has_node(area):
		if area == "UpgradeRoom":
			rollUpgrades(area)
			get_node("/root/Main/CanvasLayer/PauseMenu").visible = true
		
		for node in get_node(active_room).get_children():
			if node.is_in_group("transition"):
				node.set_deferred("monitoring", false)
				node.set_deferred("monitorable", false)
		
		for node in get_node(area).get_children():
			if node.is_in_group("transition"):
				node.set_deferred("monitoring", true)
				node.set_deferred("monitorable", true)
				
		get_node(active_room).get_node("Floor").set_collision_layer(0)
		get_node(active_room).visible = false
		camera.change_room(area)
		get_node(area).get_node("Floor").set_collision_layer(1)
		get_node(area).visible = true
		previous_room = active_room
		if previous_room == "UpgradeRoom":
			get_node("/root/Main/CanvasLayer/PauseMenu").visible = false
		active_room = area

func enter_camera(area) -> void:
	camera.enter_camera(area)

func exit_camera() -> void:
	camera.exit_camera()

func rollUpgrades(area) -> void:
	for child in get_node(area).get_node("Upgrades").get_children():
		child.call_deferred("queue_free")
		get_node(area).get_node("Upgrades").remove_child(child)
	yield(get_tree(),"idle_frame")
	for i in range(1,4):
		randomize()
		var upgrade = load("res://objects/Upgrade.tscn")
		var upgrade_instance = upgrade.instance()
		if randf() < .03:
			var choice = Recipes.ultra_rare_upgrades
			choice.shuffle()
			var pick = choice.front().to_lower()
			upgrade_instance.setup(pick)
			upgrade_instance.name = "Upgrade" + str(i)
			get_node(area).get_node("Upgrades").add_child(upgrade_instance)
			upgrade_instance.global_position = get_node(area).get_node("Upgrade"+str(i)+"Pos").global_position
			continue
		if randf() < .22:
			var choice = Recipes.rare_upgrades
			choice.shuffle()
			var pick = choice.front().to_lower()
			upgrade_instance.setup(pick)
			upgrade_instance.name = "Upgrade" + str(i)
			get_node(area).get_node("Upgrades").add_child(upgrade_instance)
			upgrade_instance.global_position = get_node(area).get_node("Upgrade"+str(i)+"Pos").global_position
			continue
		if randf() < .45:
			var choice = Recipes.uncommon_upgrades
			choice.shuffle()
			var pick = choice.front().to_lower()
			upgrade_instance.setup(pick)
			upgrade_instance.name = "Upgrade" + str(i)
			get_node(area).get_node("Upgrades").add_child(upgrade_instance)
			upgrade_instance.global_position = get_node(area).get_node("Upgrade"+str(i)+"Pos").global_position
			continue
		if randf() < 1:
			var choice = Recipes.common_upgrades
			choice.shuffle()
			var pick = choice.front().to_lower()
			upgrade_instance.setup(pick)
			upgrade_instance.name = "Upgrade" + str(i)
			get_node(area).get_node("Upgrades").add_child(upgrade_instance)
			upgrade_instance.global_position = get_node(area).get_node("Upgrade"+str(i)+"Pos").global_position
