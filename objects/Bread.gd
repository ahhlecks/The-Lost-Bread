extends KinematicBody2D


signal change_room(area)
signal enter_camera(area)
signal exit_camera()

onready var pause = $"/root/Main/CanvasLayer/PauseMenu"
onready var sprite = $Sprite
onready var trail_timer = $TrailTimer
onready var reload_timer = $ReloadTimer
onready var passive_timer = $PassiveTimer
onready var dash_timer = $DashTimer
onready var trails = $Trails

#Default upgradables 0 - 1-----
var sentience:bool = true
var chewiness:float
var toastiness:float
var butteriness:float
var sweetness:float
var bitterness:float
var saltiness:float
var temperature:float
var meatiness:float

var freshness:float
var speediness:float

# Movement Vars --------
const SPEED = 55 #minimum speed
var acceleration = 300
var friction = 300
var dash_strength = 200
var dash_speed = 0
var cancel_move:bool = false

var input_vector:Vector2
var motion:Vector2 = Vector2.ZERO

#----------------------

onready var animation_player = $AnimationPlayer
onready var crumb_particles = $CrumbParticles

# Called when the node enters the scene tree for the first time.
func _ready():
	trail_timer.start()
	passive_timer.start()
	load_vars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !cancel_move:
		input_vector = get_input_vector()
	apply_movement(input_vector, delta)
	apply_friction(input_vector, delta)
	motion = move_and_slide(motion)
	if Input.is_action_just_pressed("dash"):
		dash(dash_strength)

func get_input_vector() -> Vector2:
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if input_vector != Vector2.ZERO:
		crumb_particles.emitting = true
		if input_vector.x > 0:
			animation_player.play("Walk")
		else:
			animation_player.play("WalkLeft")
			
	else:
		crumb_particles.emitting = false
		animation_player.play("Idle")
	return input_vector.normalized()

# warning-ignore:shadowed_variable
func apply_movement(input_vector, delta) -> void:
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * (SPEED + (temperature * 50) + dash_speed), (acceleration - (butteriness * 200) + (toastiness * 220) + (dash_speed)) * delta)

# warning-ignore:shadowed_variable
func apply_friction(input_vector, delta) -> void:
	if input_vector == Vector2.ZERO:
		motion = motion.move_toward(Vector2.ZERO, (friction - (butteriness * 260) + (toastiness * 180) + (chewiness * 80)) * delta)


func _on_Area2D_area_entered(area):
	if area.visible and area.is_in_group("transition"):
		emit_signal("change_room",area.name)
	if area.visible and area.is_in_group("camera_target"):
		emit_signal("enter_camera",area)


func _on_Area2D_area_exited(area):
	if area.visible and area.is_in_group("camera_target"):
		emit_signal("exit_camera")

func load_vars():
	sentience = GameVars.sentience
	chewiness = GameVars.chewiness
	toastiness = GameVars.toastiness
	butteriness = GameVars.butteriness
	sweetness = GameVars.sweetness
	saltiness = GameVars.saltiness
	temperature = GameVars.temperature
	meatiness = GameVars.meatiness
	freshness = GameVars.freshness
	speediness = GameVars.speediness
	animation_player.playback_speed = 1 + (temperature)

func update_vars():
	GameVars.sentience = sentience
	GameVars.chewiness = chewiness
	GameVars.toastiness = toastiness
	GameVars.butteriness = butteriness
	GameVars.sweetness = sweetness
	GameVars.saltiness = saltiness
	GameVars.temperature = temperature
	GameVars.meatiness = meatiness
	GameVars.freshness = freshness
	GameVars.speediness = speediness
	pause.update_vars()
	change_type()

func play_walk() -> void:
	$AudioStreamPlayer.set_stream(GameVars.bread_walk)
	$AudioStreamPlayer.play()

func play_walk2() -> void:
	$AudioStreamPlayer.set_stream(GameVars.bread_walk2)
	$AudioStreamPlayer.play()

func change_type() -> void:
	var first_loop:bool = true
	var lowest_variance = 0
	var new_recipe:String
	for recipe in Recipes.recipes:
		var recipe_variance = 0
		var current_recipe = recipe.name
		recipe_variance += abs(chewiness - recipe.chewiness)
		recipe_variance += abs(toastiness - recipe.toastiness)
		recipe_variance += abs(butteriness - recipe.butteriness)
		recipe_variance += abs(sweetness - recipe.sweetness)
		recipe_variance += abs(saltiness - recipe.saltiness)
		recipe_variance += abs(temperature - recipe.temperature)
		recipe_variance += abs(meatiness - recipe.meatiness)
		if first_loop or recipe_variance < lowest_variance:
			new_recipe = current_recipe
			lowest_variance = recipe_variance
		first_loop = false
	if GameVars.current_type != new_recipe:
		var file2Check = File.new()
		var doFileExists = file2Check.file_exists("res://assets/characters/" + new_recipe + ".png")
		if doFileExists:
			sprite.texture = load("res://assets/characters/" + new_recipe + ".png")
		GameVars.type_history.append(GameVars.current_type)
		GameVars.current_type = new_recipe


func _on_TrailTimer_timeout():
	if GameVars.current_type == "buttered_toast":
		trail_timer.wait_time = .5
		var butter_trail_instance = load("res://objects/ButterTrail.tscn").instance()
		get_parent().trails.add_child(butter_trail_instance)


func _on_PassiveTimer_timeout():
	pass # Replace with function body.

func _on_DashTimer_timeout():
	dash_speed = 0
	cancel_move = false

func dash(strength) -> void:
	dash_speed = strength
	var mouse_vector = global_position.direction_to(get_global_mouse_position())
	input_vector = mouse_vector
	cancel_move = true
	dash_timer.start()
