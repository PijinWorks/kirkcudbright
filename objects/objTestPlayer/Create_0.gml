// custom function for player
function set_on_ground(_val = true)
	{
		if _val == true
		{
		on_ground = true;
		coyote_hang_timer = coyote_hang_frames;
	} else {
		on_ground = false;
		myFloorPlat = noone;
		coyote_hang_timer = 0;
	}
}

function check_for_semisolid_platform(_x, _y)
	{
		// Create a return variable. Normal return would cause issues
		var _rtrn = noone;
		
		// Must not be moving upwards, then check for normal collision
		if yspd >= 0 && place_meeting(_x, _y, objSemiSolidWall) 
		{
				// Create a DS list to store all colliding instances of objSemisolidWall
				var _list = ds_list_create();
				var _listSize = instance_place_list(_x, _y, objSemiSolidWall, _list, false);
				
				// Loop through colliding instance, return one if top is below the player
				for (var i = 0; i < _listSize; i++) {
					var _listInst = _list[| i];
				    if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.yspd)
					{
						// Return the id of the semisolid platform
						_rtrn = _listInst;
						// exit the loop early
						i = _listSize;
					}
				}
				// destroy ds list to free up memory
				ds_list_destroy(_list);
			}
		//Return our variable
		return  _rtrn;
	}

// controls setup
controlsSetup();
		
// Sprites
idle_spr = sprTestPlayerIdle;
walk_spr = sprTestPlayerWalk;
run_spr = sprTestPlayerRun;
jump_spr = sprTestPlayerJump;
mask_spr = sprTestPlayerIdle;
crouch_spr = sprTestPlayerCrouch;
crawl_spr = sprTestPlayerCrawl;

// moving
face = 1;
move_dir = 0;
move_type = 0;
move_spd[0] = 1.6;
move_spd[1] = 2.5
xspeed = 0;
yspd = 0;

// State Variables
crouching = false;
crouchMoveSpd = 0.8;

// jumping
grav = .275;
termVel = 4;
jump_max = 1;
jump_count = 0;
jump_hold_timer = 0;


// jump hold frame array and  jump speed array
jump_hold_frames[0] = 18;
jspd[0] = -2;
jump_hold_frames[1] = 10;
jspd[1] = -2;

on_ground = true;

// coyote time
// hang time
coyote_hang_frames = 2;
coyote_hang_timer = 0;

// jump buffer time
coyote_jump_frames = 4;
coyote_jump_timer = 0;

// Moving Platforms
myFloorPlat = noone;
earlyMoveplatXspd = false;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
moveplatXspd = 0;
moveplatMaxYspd = termVel; // How fast can the character follow a downwars moving platform
crushTimer = 0;
crushDeathTime = 3;
