// Get inputs
controlsSetup()
getControls();

// Pasue Movement if meeting X conditionals
if (global.paused = false && instance_exists(objTextBox)) {
	global.paused = true;
	image_speed = 0;
	exit;
} else {
	image_speed = 1;
}

//prevent moving while going through doors
if place_meeting(x, y, objWarp) && global.paused == false && instance_exists(objWarpTransition)
	{
			global.paused = true;
			image_speed = 0;
			xspeed = 0;
			yspd = 0;
			move_dir = 0;
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
			// Next check for ceiling slopes, otherwise, do regular collision
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
if yspd >= 0 && !place_meeting(x + xspeed, y  + 1, objCollision) && place_meeting(x + xspeed, y + abs(xspeed) + 1, objCollision)
{
	while !place_meeting(x  + xspeed, y + _sub_pixel, objCollision)
	{
		y += _sub_pixel;
	}
}
	
// move
x += xspeed;


// y movement
#region
// gravity
if coyote_hang_timer > 0
	{
		//count the timer down
		coyote_hang_timer--;
	} else {
		//activate gravity, no longer on the ground
		yspd += grav;
		set_on_ground(false);
	}

//reset jumping variables
if on_ground
	{
		jump_hold_timer = 0;
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
	// coyote_jump_timer = 0;
}
//cut off the jump by releasing button
if !jump_key
	{
		jump_hold_timer = 0;
	}
	
//jump based on the timer/holding button
if jump_hold_timer > 0
	{
		//constantly set the yspd to the jumping speed
		yspd = jspd[jump_count-1];
		//count down the timer
		jump_hold_timer--;
	}

// Y Collision and movement
// Cap falling speed
if yspd > termVel
	{
		yspd = termVel;
	}

// Collision
var _sub_pixel = .5;
// Upwards Y Collision (with ceiling slopes)
if yspd < 0 && place_meeting(x, y + yspd, objCollision)
	{
		// Jump into sloped ceilings
		var _slope_slide = false;
		//slide UpLeft Slope
		if move_dir == 0 && !place_meeting(x - abs(yspd) -1, y + yspd, objCollision)
		{
			while place_meeting(x, y + yspd, objCollision) { x -= 1; }
			_slope_slide = true;
		}
		
		// Slide UpRight Slope
		if move_dir == 0 && !place_meeting(x + abs(yspd) + 1, y + yspd, objCollision)
		{
			while place_meeting(x, y + yspd, objCollision) { x += 1; }
			_slope_slide = true;
		}
		
		// Normal YCollision
		if !_slope_slide
		{
				//scoot up to wall precisely
				var _pixel_check = _sub_pixel * sign(yspd);
				while !place_meeting(x, y + _pixel_check, objCollision)
					{
						y += _pixel_check
					}
					
					// Bonk Code
					if yspd <0 { jump_hold_timer = 0; }
					
					//set yspd to 0 to collide
					yspd = 0;
		}
	}
	
	// Floor Y Collision
	
	// Check for solid and Semisolid platforms under char
	var _clampYspd = max(0, yspd);
	var _list = ds_list_create(); // create a data structure list to store all of the objects collided into
	var _array = array_create(0);
	array_push(_array, objCollision, objSemiSolidWall);
	
	// Do the check and add objs to check
	var _listSize = instance_place_list(x, y + 1 + _clampYspd + moveplatMaxYspd, _array, _list, false);
	
	//  Loop through the colliding instances and only return one if its top is below the player
	for (var i = 0; i < _listSize; i++ ) 
	{
		// Get an instance of objCollision or objSemiSolidWall from the list
		var _listInst = _list[| i];
		 
		 // Avoid Magnetsigm
		 if (_listInst.yspd <= yspd || instance_exists(myFloorPlat))
		 && (_listInst.yspd > 0 || place_meeting(x, y + 1 + _clampYspd, _listInst))
		{
			// Return a solid wall or any semisolid walls that are below the player
			if (_listInst.object_index == objCollision)
			|| object_is_ancestor(_listInst.object_index, objCollision)
			|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd)
			{
				// Return the "highest" wall object
				if !instance_exists(myFloorPlat)
				|| _listInst.bbox_top + _listInst.yspd <= myFloorPlat.bbox_top + myFloorPlat.yspd
				|| _listInst.bbox_top + _listInst.yspd <=  bbox_bottom
				{
					myFloorPlat = _listInst; 
				}
			}
		}
		
	}
	// Destory the DS list to prevent a memory leak
	ds_list_destroy(_list);
	
	// Do another check to make sure the floor platform is actually below us
	if instance_exists(myFloorPlat) && !place_meeting(x, y + moveplatMaxYspd, myFloorPlat)
	{
		myFloorPlat = noone;	
	}
	
	// Land on the ground platform if there is one
	if instance_exists(myFloorPlat)
	{
		// Scoot up to collision precisely
		var _sub_pixel = .5
		while !place_meeting(x, y + _sub_pixel, myFloorPlat) && !place_meeting(x, y, objCollision) { y += _sub_pixel; }
		// Make sure Char doesn't end up below the top of a semisolid
		if myFloorPlat.object_index == objSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, objSemiSolidWall)
		{
			while place_meeting(x, y, myFloorPlat) { y -= _sub_pixel; };
		}
		//Floor the Y variable
		y = floor(y);
		
		// Collide with the ground
		yspd = 0;
		set_on_ground(true);
	}
	y += yspd;

/* Jump code that actually works */
//if yspd >= 0
//{
//	if place_meeting(x, y + yspd, objCollision)
//	{
//		var _pixel_check = _sub_pixel* sign(yspd);
//		while !place_meeting(x, y + _pixel_check, objCollision)
//		{
//			y += _pixel_check;
//		}
//		yspd = 0;
//	}
//	if place_meeting(x, y + 1, objCollision)
//	{
//		set_on_ground(true);	
//	}
//}

// Move
// y += yspd;

// Sprite Control
// Walking
if abs(xspeed) > 0 { sprite_index = walk_spr; }
// Not Moving
if abs(xspeed) == 0 { sprite_index = idle_spr; }
// Running
if abs(xspeed) >= move_spd[1] { sprite_index = run_spr; }
// In the air
if !on_ground { sprite_index = jump_spr;}
	// Set Collision Mask
mask_index = mask_spr;

// depth
// Honestly, not sure what this does, but I'm afraid to delete it in case its some weirdo band-aid fix...
depth = -bbox_bottom;
