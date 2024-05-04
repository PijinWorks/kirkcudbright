function scrScriptSetDefaults() {
	line_break_pos[0,pageNumber] = 999;
	line_break_num[pageNumber] = 0;
	line_break_offset[pageNumber] = 0;
	
	// Variables for every letter/character
	for (var c = 0; c < 500; c++) {
		col_1[c, pageNumber] = c_white;
		col_2[c, pageNumber] = c_white;
		col_3[c, pageNumber] = c_white;
		col_4[c, pageNumber] = c_white;
		
		float_text[c, pageNumber] = 0;
		float_dir[c, pageNumber] = c*20;
		
		shake_text[c, pageNumber] = 0;
		shake_dir[c, pageNumber] = irandom(360);
		shake_timer[c, pageNumber] = irandom(4);
		}
		
	txtBSprite[pageNumber] = sprTextBoxDefault;
	speaker_sprite[pageNumber] = noone;
	speaker_side[pageNumber] = 1;
	snd[pageNumber] = sndTextDefault;
}

// Text VFX
/// @param 1st_char
/// @param last_char
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function scrTextColor(_start, _end, _col1, _col2, _col3, _col4) {
	for (var c = _start; c <= _end; c++) {
			col_1[c, pageNumber - 1] = _col1;
			col_2[c, pageNumber - 1] = _col2;
			col_3[c, pageNumber - 1] = _col3;
			col_4[c, pageNumber - 1] = _col4;
	}
}

/// @param 1st_char
/// @param last_char
function scrTextFloat (_start, _end) {
	for (var c = _start; c <= _end; c++) {
			float_text[c, pageNumber - 1] = true;
	}
}

/// @param 1st_char
/// @param last_char
function scrTextShake (_start, _end) {
	for (var c = _start; c <= _end; c++) {
			shake_text[c, pageNumber - 1] = true;
	}
}

/// @param text
/// @param [character]
/// @param [side]
function scrText(_text){
	 scrScriptSetDefaults();
	text[pageNumber] = _text;
	
// Get character info
	if (argument_count > 1) {
		switch(argument[1])
		{
			
			//------------------ Scylla Dialogue Portraits ------------------//
			case "ScyllaDefault":
				speaker_sprite[pageNumber] = sprScyllaDefault; 
				txtBSprite[pageNumber] = sprTextBoxPink;
				snd[pageNumber] = sndScylla;
				break;
			case "ScyllaHappy":
				speaker_sprite[pageNumber] = sprScyllaHappy; 
				txtBSprite[pageNumber] = sprTextBoxPink;
				snd[pageNumber] = sndScylla;
				break;
			case "ScyllaSassy":
				speaker_sprite[pageNumber] = sprScyllaSassy; 
				txtBSprite[pageNumber] = sprTextBoxPink;
				snd[pageNumber] = sndScylla;
				break;
				
			case "ScyllaScared":
				speaker_sprite[pageNumber] = sprScyllaScared; 
				txtBSprite[pageNumber] = sprTextBoxPink;
				snd[pageNumber] = sndScylla;
				break;
				
			case "ScyllaSad":
				speaker_sprite[pageNumber] = sprScyllaSad; 
				txtBSprite[pageNumber] = sprTextBoxPink;
				snd[pageNumber] = sndScylla;
				break;
				
			//------------------ Catective Dialogue Portraits ------------------//
			case "CatectiveDefault":
				speaker_sprite[pageNumber] = sprCatectiveDefault; 
				txtBSprite[pageNumber] = sprTextBoxDefault;
				snd[pageNumber] = sndCatective;
				break;
			case "CatectiveHappy":
				speaker_sprite[pageNumber] = sprCatectiveHappy; 
				txtBSprite[pageNumber] = sprTextBoxDefault;
				snd[pageNumber] = sndCatective;
				break;
			case "CatectiveSad":
				speaker_sprite[pageNumber] = sprCatectiveSad; 
				txtBSprite[pageNumber] = sprTextBoxDefault;
				snd[pageNumber] = sndCatective;
				break;
		}
	}
	// Side of the textbox the character is on
	if (argument_count > 2) {
		speaker_side[pageNumber] = argument[2];
	}
	
	
	pageNumber++
}



/// @param option
/// @param linkID
function scrOption(_option, _link_id) {
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	
	option_number++;
}

/// @param text_id
function createTextBox(_text_id)  {
	with(instance_create_depth(x, y, -99999, objTextBox))
	{
		scrGameScript(_text_id);
	}
}