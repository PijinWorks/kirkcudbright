global.input_enabled = true;

xspeed = 0;
yspeed = 0;

char_position_x = obj_scylla.x;
char_position_y = obj_scylla.y;

move_speed = 0;

sprite[RIGHT] = spr_scylla_walk_right;
sprite[UP] = spr_scylla_walk_up;
sprite[LEFT] = spr_scylla_walk_left;
sprite[DOWN] = spr_scylla_walk_down;
sprite[IDLEDOWN] = spr_scylla_idle_down;
sprite[IDLEUP] = spr_scylla_idle_up;
sprite[IDLELEFT] = spr_scylla_idle_left;
sprite[IDLERIGHT] = spr_scylla_idle_right;

face = IDLEDOWN;