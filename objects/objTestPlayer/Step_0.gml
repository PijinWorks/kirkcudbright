getControls();

// Get out of objSolidMovePlats that have positioned themselves into the player.
#region
var _rightWall = noone;
var _leftWall = noone;
var _bottomWall = noone;
var _topWall = noone;
var _list = ds_list_create();
var _listSize = instance_place_list(x, y, objSolidMovePlat, _list, false);

// Loop through all the colliding moving platforms
for (var i = 0; i < _listSize; ++i) {
    var _listInst = _list[| i];
	
	// Find closest wall in each direction
	// Right Walls
	if _listInst.bbox_left - _listInst.xspeed >= bbox_right - 1
	{
		if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left
		{
			_rightWall = _listInst;
		}
	}
	// Left Walls
	if _listInst.bbox_right - _listInst.xspeed <= bbox_left + 1
	{
		if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right
		{
			_leftWall = _listInst;
		}
	}
	// Bottom Wall
	if _listInst.bbox_top - _listInst.yspd >= bbox_bottom - 1 {
		if !_bottomWall || _listInst.bbox_top < _bottomWall.bbox_top {
			_bottomWall = 	_listInst;
		}
	}
	// Top Wall
	if _listInst.bbox_bottom - _listInst.yspd <= bbox_top + 1 {
		if !_topWall || _listInst.bbox_bottom > _topWall.bbox_bottom {
			_topWall = _listInst;	
		}
	}
}
// Destroy the DS list to free up memory
ds_list_destroy(_list);

// Get out of the walls
// Right Wall
if instance_exists(_rightWall)
{
	var _rightDist = bbox_right - x;
	x = _rightWall.bbox_left - _rightDist;
}
// Left Wall
if instance_exists(_leftWall)
{
	var _leftDist = x - bbox_left;
	x = _leftWall.bbox_right + _leftDist;
}
// Bottom Wall
if instance_exists(_bottomWall)
{
	var _bottomDist = bbox_bottom - y;
	y = _bottomWall.bbox_top + _bottomDist;
}
// Top Wall (includes collisison for polish and crouching features)
if instance_exists(_topWall)
{
	var _topDist = y - bbox_top;
	var _targetY = _topWall.bbox_bottom + _topDist;
	// Check if there isn't a wall in the way
	if !place_meeting(x, _targetY, objCollision) {
		y = _targetY;	
	}
}
#endregion

// Don't get left behind my moving platforms
earlyMoveplatXspd = false;
if instance_exists(myFloorPlat) && myFloorPlat.xspeed != 0 && !place_meeting(x, y + moveplatMaxYspd + 1, myFloorPlat) 
{
	var _xCheck = myFloorPlat.xspeed;
	// Move character back on platform if ther is no collision in the way
	if !place_meeting(x + _xCheck, y, objCollision) {
		x += _xCheck;
		earlyMoveplatXspd = true;
	}
}

// Crouching
//------Transisiton to crouch------//
// Manual = crouch_key | Automatic = wall collision
if on_ground && (crouch_key || place_meeting(x, y, objCollision)) {
		crouching = true;
}
// Change collision mask
if crouching {
	mask_index = crouch_spr;
}
//------Transisiton out of crouching------//
// Manual = !crouch_key | Automatic  = !on_ground
if crouching && (!crouch_key || !on_ground)
{
	// Check if player can uncrouch
	mask_index = idle_spr
	// Uncrouch if no solid wall in the way.
	if !place_meeting(x, y, objCollision) {
		crouching = false;
	// Go back to crouching mask index if above is not true
	} else 
	{
		mask_index = crouch_spr;
	}
}

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

// No movement while crouching
if crouching {  xspeed =  move_dir * crouchMoveSpd };

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
downSlopeSemiSolid = noone;
if yspd >= 0 && !place_meeting(x + xspeed, y  + 1, objCollision) && place_meeting(x + xspeed, y + abs(xspeed) + 1, objCollision)
{
	// Check for a semisolid wall in the way
	downSlopeSemiSolid = check_for_semisolid_platform(x + xspeed, y +abs(xspeed) + 1);
	// Precisely move down slope if  there isn't a semisolid in the way
	if !instance_exists(downSlopeSemiSolid) 
	{
		while !place_meeting(x  + xspeed, y + _sub_pixel, objCollision)
			{
				y += _sub_pixel;
			}
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
var _floorIsSolid = false;
if instance_exists(myFloorPlat)
&& (myFloorPlat.object_index == objCollision || object_is_ancestor(myFloorPlat.object_index, objCollision))
{
	_floorIsSolid = true;
}
if jump_key_buffered && jump_count < jump_max && (!crouch_key ||  _floorIsSolid)
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
}

// Old jumping code that worked, just in case I fucking fail.
#region
if jump_key_buffered && !crouch_key && jump_count < jump_max
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
} 
#endregion

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
	y = floor(y);
	
	// Check for solid and Semisolid platforms under char
	var _clampYspd = max(0, yspd);
	var _list = ds_list_create(); // create a data structure list to store all of the objects collided into
	var _array = array_create(0);
	array_push(_array, objCollision, objSemiSolidWall);
	
	// Do the check and add objs to check
	var _listSize = instance_place_list(x, y + 1 + _clampYspd + moveplatMaxYspd, _array, _list, false);
	
	var _yCheck = y + 1+ _clampYspd;
	if instance_exists(myFloorPlat) { _yCheck += max(0, myFloorPlat.yspd);	};
	var _semiSolid = check_for_semisolid_platform(x, _yCheck);
	
	//  Loop through the colliding instances and only return one if its top is below the player
	for (var i = 0; i < _listSize; i++ ) 
	{
		// Get an instance of objCollision or objSemiSolidWall from the list
		var _listInst = _list[| i];
		 
		 // Avoid Magnetsigm
		 if (_listInst != forgetSemiSolid
		 && (_listInst.yspd <= yspd || instance_exists(myFloorPlat))
		 && (_listInst.yspd > 0 || place_meeting(x, y + 1 + _clampYspd, _listInst)))
		 || (_listInst == _semiSolid) // High Resolution Art Fix
		{
			// Return a solid wall or any semisolid walls that are below the player
			if _listInst.object_index  == objCollision
			|| object_is_ancestor(_listInst.object_index, objCollision)
			|| floor (bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd)
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
	
	// Downslope semisolid for making sure semisolids aren't missed while going down slopes
	if instance_exists(downSlopeSemiSolid) {
		myFloorPlat = downSlopeSemiSolid;	
	}
	// Do another check to make sure the floor platform is actually below char
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
	// Manually fall through a semisolid platform
	if crouch_key && jump_key_pressed
	{
		// Make sure we have a floor that is semisolid
		if instance_exists(myFloorPlat)
		&& (myFloorPlat.object_index == objSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, objSemiSolidWall))
		{
			// Check if we can go below the semisolid
			var _yCheck = max(1, myFloorPlat.yspd + 1);
			if !place_meeting(x, y + _yCheck, objCollision)
			{
				// Move below the platforms
				y += 1;
				
				// inheret any downward speed from myFloorPlat
				yspd = _yCheck - 1;
				
				// Forget recently passed platform
				forgetSemiSolid = myFloorPlat;
				
				// No more floor platform
				set_on_ground(false);
			}
		}
	}

	// Move
	if !place_meeting(x, y + yspd, objCollision) { y += yspd; }
	
// Reset forgetSemiSolid Variable
if instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid) {
		forgetSemiSolid = noone;
}
	
//-----------------------------------Final moving platform collisions and movement-----------------------------------//
// X - Collision and moveplatXspd 
if instance_exists(myFloorPlat) { moveplatXspd = myFloorPlat.xspeed; };

// Move with the platform  horizontally
if !earlyMoveplatXspd
{
	if place_meeting(x + moveplatXspd, y, objCollision) {
		// Scoot up to wall precisely
		var _sub_pixel = .5;
		var _pixel_check = _sub_pixel * sign(moveplatXspd);
		while !place_meeting(x + _pixel_check, y ,objCollision) {
			x += _pixel_check;	
		}
	
		// Set moveplatXspd  to 0 to finish collision
		moveplatXspd = 0;
	}
	// Move
	x += moveplatXspd;
}

// Y-Collision Snap Char to myFloorPlat if it's moving vertically
if instance_exists(myFloorPlat) 
&& (myFloorPlat.yspd != 0
|| myFloorPlat.object_index == objSolidMovePlat
|| object_is_ancestor(myFloorPlat.object_index, objSolidMovePlat)
|| myFloorPlat.object_index == objSemiSolidMovePlat
|| object_is_ancestor(myFloorPlat.object_index, objSemiSolidMovePlat))
{
	// Snap 	to the top of the floor platform (unfloor the Y variable so it's not choppy
	if !place_meeting(x, myFloorPlat.bbox_top, objCollision)
	&& myFloorPlat.bbox_top >= bbox_bottom - moveplatMaxYspd
	{
		y = myFloorPlat.bbox_top;
	}
// Going up into a solid wall while on a Semisolid platform (Regioned code made redundant by code block below.)
#region
	if myFloorPlat.yspd < 0 && place_meeting(x, y + myFloorPlat.yspd, objCollision)
	{
			// Get pushed down through the Semisolid floor platform
			if myFloorPlat.object_index == objSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, objSemiSolidWall)
			{
				// Get pushed down through the semi solid
				var _sub_pixel = .25
				while place_meeting(x, y + myFloorPlat.yspd, objCollision) {
					y += _sub_pixel;
					// If pushed into a solid wall while going down, push character out
					while place_meeting(x, y, objCollision) { 
						y-= _sub_pixel 
					}
					y = round(y);
				}
				// Cancel the myFloorPlat variable
				set_on_ground(false);
			}
	}
	#endregion
}

// Get pushed down through semisolid platform by a moving solid platform
if instance_exists(myFloorPlat) 
&& (myFloorPlat.object_index == objSemiSolidWall || object_is_ancestor(myFloorPlat.object_index, objSemiSolidWall))
&& place_meeting(x, y, objCollision)
{
		// Move down to get below a semisolid wall if stuck inside collision
		// If still stuck, character has been crushed
		
		// Don't check too far, don't want the character to warp below walls
		var _maxPushDist = 10;
		var _pushedDist = 0;
		var _startY = y;
		
		while (place_meeting(x, y, objCollision)) && _pushedDist <= _maxPushDist {
		    y++;
			_pushedDist++;
		}
		// forget myFloorPlat
		set_on_ground(false);
		
		// If the character is still inside a wall at this point, telelport to starting Y-pos o avoid weirdo shit. Most likely this means the character has been crushed/
		if _pushedDist > _maxPushDist {
			y = _startY;	
		}
}

// Check if Char is crushed
image_blend = c_white;
if place_meeting(x, y, objCollision)
{
	image_blend = c_blue;	
}



//Jump code that actually works
#region
if yspd >= 0
{
	if place_meeting(x, y + yspd, objCollision)
	{
		var _pixel_check = _sub_pixel* sign(yspd);
		while !place_meeting(x, y + _pixel_check, objCollision)
		{
			y += _pixel_check;
		}
		yspd = 0;
	}
	if place_meeting(x, y + 1, objCollision)
	{
		set_on_ground(true);	
	}
}
#endregion

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
// Crouch Code
if crouching { sprite_index = crouch_spr;}
// Set Collision Mask
mask_index = mask_spr;
if crouching { mask_index = crouch_spr; }

// depth
// Honestly, not sure what this does, but I'm afraid to delete it in case its some weirdo band-aid fix...
depth = -bbox_bottom;
