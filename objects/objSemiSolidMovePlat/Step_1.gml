// Move in a circle
dir += rotSpd;

// Get target positions
var _targetX = xstart + lengthdir_x(radius, dir);
var _targetY = ystart + lengthdir_y(radius, dir);

// Get xspd and yspd
xspeed = _targetX - x;
yspd = _targetY - y;


// Move the fucker
x += xspeed;
y += yspd;