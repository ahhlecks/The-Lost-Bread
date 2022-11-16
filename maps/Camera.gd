extends Camera2D


export (NodePath) var camera_target
export (NodePath) var character

var camera_lock:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_target = ""

func change_room(room:String) -> void:
	if get_parent().get_node(room).has_node("CameraTarget"):
		camera_target = get_path_to(get_parent().get_node(room).get_node("CameraTarget"))
	else:
		camera_target = ""

func enter_camera(camera) -> void:
	camera_lock = true
	global_position = camera.global_position

func exit_camera() -> void:
	camera_lock = false
	global_position = get_node(character).global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if !camera_lock:
		global_position = get_node(character).global_position
