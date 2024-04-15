if place_meeting(x, y, obj_scylla) && !instance_exists(obj_warp_transition)
{
	var inst = instance_create_depth(0, 0, -9999999, obj_warp_transition);
	inst.target_x = target_x;
	inst.target_y = target_y;
	inst.target_rm = target_rm;
	inst.target_face = target_face;
}