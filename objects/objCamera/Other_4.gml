// exit if there is no player
if !instance_exists(objTestPlayer) 
	{
		exit;
	}
	
// get camera size
var _camera_width =  camera_get_view_width(view_camera[0]);
var _camera_height = camera_get_view_height(view_camera[0]);

// get camera target coordinates
var _cam_x = objTestPlayer.x - _camera_width/2;
var _cam_y = objTestPlayer.y - _camera_height/2;

//constrain cam to room borders
_cam_x = clamp(_cam_x, 0, room_width - _camera_width);
_cam_y = clamp(_cam_y, 0, room_height - _camera_height);

// set camera coordinates at start of room
final_cam_x = _cam_x;
final_cam_y = _cam_y;