// Dynamically get width and height of menu
var _newW = 0;
for(var i = 0; i < opLength; i++) {
	var opWidth = string_width(option[menuLevel, i]);
	_newW = max(_newW, opWidth);
}
width = _newW + opBorder*2;
height = opBorder*2 + string_height(option[0, 0]) + (opLength-1)* opSpace;

/* Center Menu
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2 - width/2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2 - height/2;
*/

// Draw menu background
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

// Draw Options Text from array
draw_set_font(ftFibberish);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

for(var i = 0; i < opLength; i++) {
	var selectionColor = c_white;
	if pos == i {
		selectionColor = c_yellow;
	}
	draw_text_color(x+opBorder, y+opBorder + opSpace * i, option[menuLevel, i], selectionColor, selectionColor, selectionColor, selectionColor, 1);
}