controlsSetup();
getControls();


textboxX = camera_get_view_x(view_camera[0]) - 195;
textboxY = camera_get_view_y(view_camera[0]) + 290;

// Setup
if (setup == false) {
	setup = true;
	draw_set_font(ftFibberish);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	// Loop through the pages
	pageNumber = array_length(text);
	for (var p = 0; p < pageNumber; p++)
		{
			// Find how many characters are on each page and store that number in the "textLenght" array
			textLength[p] = string_length(text[p]);
			
			// Get the x position for the textbox
			// Character on the left
			text_x_offset[p] = 320;
			portrait_x_offset[p] = 180;
			image_xscale = 1;
			// Character on the right
			if (speaker_side[p] == -1) {
					text_x_offset[p] = 320;
					portrait_x_offset[p] = 620;

			}
			
			// No Character (Center the textbox)
			if (speaker_sprite[p] == noone) {
				text_x_offset[p] = 320;
			}
			 
			 //  Setting individual characters and finding where the lines of text should break
			 for (var c = 0; c < textLength[p]; c++){
				 var _char_pos = c + 1;
				 
				 // Store individual characters in the "char" array
				 char[c, p] = string_char_at(text[p], _char_pos);
				 
				 // Get current width of the line
				 var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
				 var _current_text_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
				 
				 // Get the last free space
				 if (char[c, p] == " ") {
					 last_free_space = _char_pos + 1;
				 }
					 
				// Get the line breaks
				if (_current_text_w - line_break_offset[p] > lineWidth)
					{
						line_break_pos[line_break_num[p], p] = last_free_space;
						line_break_num[p]++;
						var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space);
						var _last_free_space_string = string_char_at(text[p], last_free_space);
						line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string);
					}
						
				 }
				 
				 // Get each characters coordinates
				 for (var c = 0; c < textLength[p]; c++) {
					 var _char_pos = c + 1;
					 var _txt_x = textboxX + text_x_offset[p] + border;
					 var _txt_y  = textboxY + border;
					 var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
					 var _current_text_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
					 var _txt_line = 0;
					 
					 // Compensate for string breaks
					 for (var lb = 0; lb < line_break_num[p]; lb++) {
						 if _char_pos >= line_break_pos[lb, p]
						 {
							 var _str_copy = string_copy(text[p], line_break_pos[lb, p], _char_pos - line_break_pos[lb, p]);
							 _current_text_w = string_width(_str_copy);
							 
							 // Record the "line" this character should be on
							 _txt_line = lb + 1; // +1 since lb starts at 0
						 }
					 }
					 // Add to the X and Y coordinates based on the new info
					 char_x[c, p] = _txt_x + _current_text_w;
					 char_y[c, p] = _txt_y + _txt_line * lineSep;
				 }
					 
			 }
		}
		
// Typing the text
if (drawChar < textLength[page]) {
	drawChar += textSpeed;
	drawChar = clamp(drawChar, 0, textLength[page]);
	var _check_char = string_char_at(text[page], drawChar);
	if (_check_char == "." || _check_char == "," || _check_char == ";" || _check_char == "!" || _check_char == "?") {
		text_pause_timer = text_pause_time;
	}
	else {
		if (snd_count < snd_delay) {
			snd_count++;
		} else {
			snd_count = 0;
			audio_play_sound(snd[page], 9, false);
		}
	}
		
} else {
	text_pause_timer--;
}

// Flip through the pages
if (accept_key_pressed) {
	// If the typing is done, go to next page
	if drawChar == textLength[page]
	{
		// next page
		if page < pageNumber -1
		{ 
			page++;
			drawChar = 0;
		} else {
			// Link text for options
			if option_number > 0 {
				createTextBox(option_link_id[option_pos]);
			}
			instance_destroy();
		}	
	}
	// If not done typing
	else {
		drawChar = textLength[page];
	}
}

// Draw the textbox //
 var textBX = textboxX + text_x_offset[page]; 
 var textBY = textboxY;
txtBImage += txtBImageSpeed;
txtBSpriteW = sprite_get_width(txtBSprite[page]);
txtBSpriteH = sprite_get_height(txtBSprite[page]);

// Draw the speaker
if (speaker_sprite[page] != noone) {
	if (drawChar == textLength[page]) {
		image_index = 0;
	}
	sprite_index = speaker_sprite[page];
	var _speaker_x = textboxX + portrait_x_offset[page];
	if (speaker_side[page] == -1) {
		_speaker_x += sprite_width;
	}
	// Draw the speaker

	draw_sprite_ext(sprite_index, image_index, _speaker_x, textboxY - 200, speaker_side[page], 1, 0, c_white, 1);
}

 // Back of the text box
 draw_sprite_ext(txtBSprite[page],txtBImage,textBX, textBY, textboxWidth/txtBSpriteW, textboxHeight/txtBSpriteH, 0, c_white, 1);

// Options
if drawChar = textLength[page] && page == pageNumber - 1 {
	
	// Option Selection
	option_pos += crouch_key_pressed - up_key_pressed;
	option_pos = clamp(option_pos, 0, option_number -1);
	
	var opSpace = 25;
	var opBord = 6;
	for (var op = 0; op < option_number; op++)
	{
		// Draw option box
		var oWidth = string_width(option[op]) + opBord*2;

		draw_sprite_ext(txtBSprite[page], txtBImage, textBX + 16, textBY - opSpace*option_number + opSpace*op, oWidth/txtBSpriteW, (opSpace - 1)/txtBSpriteH, 0, c_white, 1);
		
		// Draw Arrow
		if option_pos == op {

			draw_sprite_ext(sprSelectIcon, image_index, textBX, textBY - opSpace*option_number + opSpace*op + 4, 1, 1,  0,c_white, 1);
		}
		
		// Draw option text
		draw_text(textBX + 16 + opBord, textBY - opSpace*option_number + opSpace*op + 4, option[op]);
	}
}

// Draw the text
for (var c = 0; c < drawChar; c++) {
	// Text VFX
	// Wavy Text
	var _float_y = 0;
	if (float_text[c, page] == true) {
		float_dir[c, page] += -6;
		_float_y = dsin(float_dir[c, page])*1;
	}
	
	// Shake Text
	var _shake_x = 0;
	var _shake_y = 0;
	if (shake_text[c, page] == true) {
		shake_timer[c, page]--;
		if (shake_timer[c, page] <= 0) {
			shake_timer[c, page] = irandom_range(4, 8);
			shake_dir[c, page] = irandom(360);
		}
		if (shake_timer[c, page] <= 2) {
			_shake_x = lengthdir_x(1, shake_dir[c, page]);
			_shake_y = lengthdir_y(1, shake_dir[c, page]);
		}
	}
	
	// The text 
	draw_text_color(char_x[c, page] + _shake_x, char_y[c, page] + _float_y + _shake_y, char[c, page], col_1 [c, page], col_2 [c, page], col_3[c, page], col_4 [c, page], 1)
}