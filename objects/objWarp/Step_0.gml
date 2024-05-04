if place_meeting(x, y, objTestPlayer) && !instance_exists(objWarpTransition)
{
	var inst = instance_create_depth(0, 0, -9999999, objWarpTransition);
	inst.target_x = target_x;
	inst.target_y = target_y;
	inst.target_rm = target_rm;
}