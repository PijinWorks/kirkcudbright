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

// controls setup
controlsSetup();
		
// Sprites
idle_spr = sprTestPlayerIdle;
walk_spr = sprTestPlayerWalk;
run_spr = sprTestPlayerRun;
jump_spr = sprTestPlayerJump;
mask_spr = sprTestPlayerIdle;
crouch_spr = sprTestPlayerCrouch;
roll_spr = sprTestPlayerRoll;

// moving
face = 1;
move_dir = 0;
move_type = 0;
move_spd[0] = 1.6;
move_spd[1] = 2.5
xspeed = 0;
yspd = 0;

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
moveplatXspd = 0;
moveplatMaxYspd = termVel; // How fast can the character follow a downwars moving platform
