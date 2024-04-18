// custom function for player
function set_on_ground(_val = true)
	{
		if _val == true
		{
		on_ground = true;
		coyote_hang_timer = coyote_hang_frames;
	} else {
		on_ground = false;
		coyote_hang_timer = 0;
	}
}
		


// controls setup
controlsSetup();

// moving
move_dir = 0;
move_spd = 2;
xspeed = 0;
yspeed = 0;

// jumping
grav = .275;
term_vel = 4;
jump_max = 1;
jump_count = 0;
jump_hold_timer = 0;

// jump hold frame array
jump_hold_frames[0] = 18;
jump_hold_frames[1] = 10;

// juump speed array
jspeed[0] = -2;
jspeed[1] = 1;

on_ground = true;

// coyote time
// hang time
coyote_hang_frames = 2;
coyote_hang_timer = 0;

// jump buffer time
coyote_jump_frames = 4;
coyote_jump_timer = 0;
