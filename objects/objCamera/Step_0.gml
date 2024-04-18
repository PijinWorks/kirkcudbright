// fullscreen toggle
if keyboard_check_pressed(vk_alt) && keyboard_check_pressed(vk_delete)
	{
		window_set_fullscreen( !window_get_fullscreen() );
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

// set cam coordinate vaiables
final_cam_x +=  (_cam_x - final_cam_x) * cam_trail_speed;
final_cam_y += (_cam_y - final_cam_y) * cam_trail_speed;

//set camera coordinates
camera_set_view_pos(view_camera[0], final_cam_x, final_cam_y);