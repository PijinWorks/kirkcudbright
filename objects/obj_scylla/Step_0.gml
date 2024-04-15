right_key = keyboard_check(ord("D")) || keyboard_check(vk_right) || (gamepad_button_value(0 ,gp_padr))|| (gamepad_axis_value(0, gp_axislh));
left_key = keyboard_check(ord("A"))  || keyboard_check(vk_left) || (gamepad_button_value(0 ,gp_padl)) || -(gamepad_axis_value(0, gp_axislh));
up_key = keyboard_check(ord("W"))  || keyboard_check(vk_up) || (gamepad_button_value(0 ,gp_padu)) || -(gamepad_axis_value(0, gp_axislv));
down_key = keyboard_check(ord("S")) || keyboard_check(vk_down) || (gamepad_button_value(0 ,gp_padd)) || (gamepad_axis_value(0, gp_axislv));
running = keyboard_check(vk_shift) || (gamepad_button_value(0, gp_face2));
		
if up_key && left_key
	{
		move_speed = 0;
		face = IDLEUP || IDLELEFT
	}
else if down_key && left_key
	{
		move_speed = 0;
		face = IDLEDOWN || IDLELEFT
	}
else if down_key && right_key
	{
		move_speed = 0;
		face = IDLEDOWN || IDLERIGHT
	}
else if up_key && right_key
	{
		move_speed = 0;
		face = IDLEUP || IDLELEFT
	}
	
// slow down when getting in beds - 04/06/2024
// this code doesn't do anything, I can't figure out why -  04/06/2024
if (place_meeting(x, y, obj_bed_pink_top)) {
	move_speed = 3;
		}
if  (place_meeting(x, y, obj_bed_pink_bottom)) {
	move_speed = 3;
		}
else {
	move_speed = move_speed;
}

// setting move speed
xspeed = (right_key - left_key) * move_speed;
yspeed = (down_key - up_key) * move_speed;

//prevent moving while going through doors
if instance_exists(obj_pauser)
	{
			xspeed = 0;
			yspeed = 0;
			global.input_enabled = false;
	}
else {
	global.input_enabled = true;
}

	
// collision
if (place_meeting(x, y, obj_debug_wall)) {
	for(var i = 0; i < 1000; ++i) {
		//right
		if(!place_meeting(x + i, y, obj_debug_wall)) {
			x += i;
			break;
		}
		//left
		if(!place_meeting(x - i, y, obj_debug_wall)) {
			x -= i;
			break;
		}
		//up
		if(!place_meeting(x, y - i, obj_debug_wall)) {
			y -= i;
			break;
		}
		//down
		if(!place_meeting(x, y + i, obj_debug_wall)) {
			y += i;
			break;
		}
		//top right
		if(!place_meeting(x + i, y - i, obj_debug_wall)) {
			x += i;
			y -= i;
			break;
		}
		//top left
		if(!place_meeting(x - i, y - i, obj_debug_wall)) {
			x -= i;
			y -= i;
			break;
		}
		//bottom right
		if(!place_meeting(x + i, y + i, obj_debug_wall)) {
			x += i;
			y += i;
			break;
		}
		//bottom left
		if(!place_meeting(x - i, y + i, obj_debug_wall)) {
			x -= i;
			y += i;
			break;
		}
	}
}
	

x = x + xspeed; // x += xspeed
y = y + yspeed; // y += yspeed

//set sprite idle direction depending on moving direction
if right_key && global.input_enabled = true
	{
		move_speed = 3;
		face = IDLERIGHT;
	}
else if left_key && global.input_enabled = true
	{
		move_speed = 3;
		face = IDLELEFT;
	}
else if up_key && global.input_enabled = true
	{
		move_speed = 3;
		face = IDLEUP
	}
else if down_key && global.input_enabled = true
	{
		move_speed = 3;
		face = IDLEDOWN;
	}	
else
	{
		move_speed = 0;
	}
	
if face = UP && move_speed == 0
	{
		face = IDLEUP;
	}
if face = DOWN && move_speed == 0
	{
		face = IDLEDOWN;
	}
if face = LEFT && move_speed == 0
	{
		face = IDLELEFT;
	}
if face = RIGHT && move_speed == 0
	{
		face = IDLERIGHT;
	}		

//sprinting
if running && global.input_enabled = true
	{
		move_speed = 7;
	}
else
	{
		move_speed = move_speed;
	}


	
//set player sprite
if yspeed == 0 && global.input_enabled = true
	{
		if xspeed > 0 {face = RIGHT}
		if xspeed < 0 {face = LEFT}
	}

if  xspeed == 0 && global.input_enabled = true
	{
	
		if yspeed > 0 {face = DOWN}
		if yspeed < 0 {face = UP}
	}		
	

sprite_index = sprite[face];

// depth
depth = -bbox_bottom;
