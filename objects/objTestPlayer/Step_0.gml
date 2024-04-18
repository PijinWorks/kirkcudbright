// Get inputs
getControls();

// x movement
// direction
move_dir = right_key - left_key;

// get xspeed
xspeed = move_dir * move_spd;

// x collision
var _sub_pixel = .5;
if place_meeting(x + xspeed, y, objCollision)
	{
		// scoot up to wall precisely
		var _pixel_check = _sub_pixel * sign(xspeed);
		while !place_meeting(x + _pixel_check, y, objCollision)
		{
			x += _pixel_check
		}
		
		//set x speed to zero to collide
		xspeed = 0;
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
if place_meeting(x, y + yspeed, objCollision)
{
	//scoot up to wall precisely
	var _pixel_check = _sub_pixel * sign(yspeed);
	while !place_meeting(x, y + _pixel_check, objCollision)
	{
		y += _pixel_check
	}
	//bonk code
	if yspeed < 0
	{
		jump_hold_timer = 0;
	}
	
	//set y speed to 0 to collide with ground
	yspeed = 0;
}

if yspeed >= 0 &&  place_meeting(x, y+1, objCollision)
{
	set_on_ground(true);
}

// move
y += yspeed;