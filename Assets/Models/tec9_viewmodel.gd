tool
extends Spatial

export(float) var viewmodelfov: float = 50.0 setget set_viewmodelfov

func set_viewmodelfov(val: float) -> void:
	viewmodelfov = val
	var hand_mesh = get_node("pov_pilot_light_jester_f_skeleton/Skeleton/pov_pilot_light_jester_f")
	var weapon_mesh = get_node("pov_pilot_light_jester_f_skeleton/Skeleton/tec9")
	
	for i in range(hand_mesh.get_surface_material_count()):
		var mat: Material = hand_mesh.get_active_material(i)
		if mat is ShaderMaterial:
			mat.set_shader_param("viewmodel_fov", val)
	for i in range(weapon_mesh.get_surface_material_count()):
		var mat: Material = weapon_mesh.get_active_material(i)
		if mat is ShaderMaterial:
			mat.set_shader_param("viewmodel_fov", val)
	pass

