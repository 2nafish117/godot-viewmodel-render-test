class_name FpKbCamera
extends Position3D

const MOUSE_SENSITIVITY_FACTOR := 0.001

onready var camera := $H/V/Camera


# transforms to interpolate the fp_camera
onready var initial_camera_xform: Transform = transform
onready var old_xform: Transform
onready var current_xform: Transform

onready var mouse_horizontal_sensitivity: float = 1.0
var mouse_horizontal_sensitivity_modifier: float = 1.0
onready var mouse_vertical_sensitivity: float = 1.0
var mouse_vertical_sensitivity_modifier: float = 1.0

func modify_camera(modifier: float):
	mouse_horizontal_sensitivity_modifier = modifier
	mouse_vertical_sensitivity_modifier = modifier
	
# get the basis of H node
func get_hbasis() -> Basis:
	return $H.global_transform.basis

# get the basis of H node
func get_local_hbasis() -> Basis:
	return $H.transform.basis

# get the basis of V node or Camera
func get_basis() -> Basis:
	return $H/V.global_transform.basis

# get the basis of V node or Camera
func get_local_basis() -> Basis:
	return $H/V.transform.basis

# get the horizontal rotation (yaw)
func get_hrot() -> float:
	return $H.rotation.y

# get the vertical rotation (pitch)
func get_vrot() -> float:
	return $H/V.rotation.x

func get_forward_vector() -> Vector3:
	return -get_basis().z

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var hrot: float = -event.relative.x
		var vrot: float = -event.relative.y
		$H.rotate_y(hrot * mouse_horizontal_sensitivity_modifier * mouse_horizontal_sensitivity * MOUSE_SENSITIVITY_FACTOR)
		$H/V.rotate_x(vrot * mouse_vertical_sensitivity_modifier * mouse_vertical_sensitivity * MOUSE_SENSITIVITY_FACTOR)
		$H/V.rotation.x = clamp($H/V.rotation.x, -PI * 0.47, PI * 0.47)
		
		
