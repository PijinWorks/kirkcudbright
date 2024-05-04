// Get inputs
controlsSetup()
getControls();


if (global.paused = false && instance_exists(objTextBox)) {
	global.paused = true;
	image_speed = 0;
	exit;
} else {
	image_speed = 1;
}


// x movement
// direction
move_dir = right_key - left_key;
// Get sprite face direction
if move_dir != 0
	{
		face = move_dir;
	}
	
//prevent moving while going through doors
if place_meeting(x, y, objWarp)
	{
			xspeed = 0;
			yspeed = 0;
			move_dir = 0;
	}

// get xspeed
move_type = run_key;
xspeed = move_dir * move_spd[move_type];

// x collision
var _sub_pixel = .5;
if place_meeting(x + xspeed, y, objCollision)
	{
		
		// first check if there is a slope to go up
		if !place_meeting(x + xspeed, y - abs(xspeed) - 1, objCollision)
		{
			while  place_meeting(x + xspeed, y, objCollision) { y -= _sub_pixel; }
		}
			// Next check for cieling slopes, otherwise, do regular collision
			else 
				{
					//ceiling slopes
					if !place_meeting(x + xspeed, y + abs(xspeed) + 1, objCollision)
					{
						while place_meeting(x + xspeed, y, objCollision) {  y += _sub_pixel; }
					}
					//Normal collision check
					
					else
					{
						// scoot up to wall precisely
						var _pixel_check = _sub_pixel * sign(xspeed);
						while !place_meeting(x + _pixel_check, y, objCollision) { x += _pixel_check }
				
						//set x speed to zero to collide
						xspeed = 0;
					}
				}
	}


// Going down slopes
if yspeed >= 0 && !place_meeting(x + xspeed, y  + 1, objCollision) && place_meeting(x + xspeed, y + abs(xspeed) + 1, objCollision)
{
	while !place_meeting(x  + xspeed, y + _sub_pixel, objCollision)
	{
		y += _sub_pixel;
	}
}
	
// move
x += xspeed;


// y movement

// gravity
if coyote_hang_timer > 0
	{
		//count the timer down
		coyote_hang_timer--;
	} else {
		//activate gravity, no longer on the ground
		yspeed += grav;
		set_on_ground(false);
	}

//reset jumping variables
if on_ground
	{
		jump_count = 0;
		coyote_jump_timer = coyote_jump_frames
	} else {
		// if in air, can't jump again
		coyote_jump_timer--;
		if jump_count == 0 && coyote_jump_timer <= 0
			{
				jump_count = 1;
			}
			coyote_hang_timer = 0;
	}
	
// Initiate the  Jump
if jump_key_buffered && jump_count < jump_max
{
	//reset the buffer
	jump_key_buffered = false;
	jump_key_buffer_timer = 0;
	
	// add to jump counter
	jump_count++;
	
	//set the jump hold timer
	jump_hold_timer = jump_hold_frames[jump_count-1];
	
	// no longer on the ground
	set_on_ground(false);
	coyote_jump_timer = 0;
}
//cut off the jump by releasing button
if !jump_key
	{
		jump_hold_timer = 0;
	}
	
//jump based on the timer/holding button
if jump_hold_timer > 0
	{
		//constantly set the yspeed to the jumping speed
		yspeed = jspeed[jump_count-1];
		//count down the timer
		jump_hold_timer--;
	}

// Y Collision and movement
// Cap falling speed
if yspeed > term_vel
	{
		yspeed = term_vel;
	}

var _sub_pixel = .5;

// Upwards Y Collisio (with ceiling slopes)
if yspeed < 0 && place_meeting(x, y + yspeed, objCollision)
	{
		// Jump into sloped ceilings
		var _slope_slide = false;
		//slide UpLeft Slope
		if move_dir == 0 && !place_meeting(x - abs(yspeed) -1, y + yspeed, objCollision)
		{
			while place_meeting(x, y + yspeed, objCollision) { x -= 1; }
			_slope_slide = true;
		}
		
		// Slide UpRight Slope
		if move_dir == 0 && !place_meeting(x + abs(yspeed) + 1, y + yspeed, objCollision)
		{
			while place_meeting(x, y + yspeed, objCollision) { x += 1; }
			_slope_slide = true;
		}
		
		// Normal YCollision
		if !_slope_slide
		{
				//scoot up to wall precisely
				var _pixel_check = _sub_pixel * sign(yspeed);
				while !place_meeting(x, y + _pixel_check, objCollision)
					{
						y += _pixel_check
					}
					
					// Bonk Code
					if yspeed <0 { jump_hold_timer = 0; }
					
					//set yspeed to 0 to collide
					yspeed = 0;
		}
	}

// Dowwards Y Collision
if yspeed >= 0
{
	if place_meeting(x, y + yspeed, objCollision)
	{
		//scoot up to wall precisely
		var _pixel_check = _sub_pixel * sign(yspeed);
		while !place_meeting(x, y + _pixel_check, objCollision)
		{
			y += _pixel_check
		}
		//set y speed to 0 to collide with ground
		yspeed = 0;
	}

	if  place_meeting(x, y+1, objCollision)
	{
		set_on_ground(true);
	}
}

// move
y += yspeed;

// Sprite Control
// Walking
if abs(xspeed) > 0
	{
		sprite_index = walk_spr;
	}

// Not Moving
if abs(xspeed) == 0
	{
		sprite_index = idle_spr;
	}
// Running
if abs(xspeed) >= move_spd[1]
	{
		sprite_index = run_spr;
	}
// In the air
if !on_ground 
	{
		sprite_index = jump_spr;
	}
// If on ground and still, crouch	
if on_ground = true && crouch_key
	{
		sprite_index = crouch_spr;

	}
if on_ground = true  && roll_key
	{
		sprite_index = roll_spr;
	}
	
// Set Collision Mask
mask_index = mask_spr;

// depth
depth = -bbox_bottom;
