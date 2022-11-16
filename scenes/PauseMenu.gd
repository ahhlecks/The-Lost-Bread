extends Control

class_name PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/TextureRect.texture = load("res://assets/characters/" + GameVars.current_type + ".png")
	update_vars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		visible = !visible

func update_vars() -> void:
	$Panel/Type.text = GameVars.current_type.capitalize()
	var file2Check = File.new()
	var doFileExists = file2Check.file_exists("res://assets/characters/" + GameVars.current_type + ".png")
	if doFileExists:
		$Panel/TextureRect.texture = load("res://assets/characters/" + GameVars.current_type + ".png")
	$Panel/VBoxContainer/Freshness/TextureProgress.value = GameVars.freshness * 100
	$Panel/VBoxContainer/Chewiness/TextureProgress.value = GameVars.chewiness * 100
	$Panel/VBoxContainer/Toastiness/TextureProgress.value = GameVars.toastiness * 100
	$Panel/VBoxContainer/Butteriness/TextureProgress.value = GameVars.butteriness * 100
	$Panel/VBoxContainer/Sweetness/TextureProgress.value = GameVars.sweetness * 100
	$Panel/VBoxContainer/Saltiness/TextureProgress.value = GameVars.saltiness * 100
	$Panel/VBoxContainer/Meatiness/TextureProgress.value = GameVars.meatiness * 100
	$Panel/VBoxContainer/Temp/TextureProgress.value = GameVars.temperature * 100
