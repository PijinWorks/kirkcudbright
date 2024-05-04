depth = -100000000000000000000000000000000;

// Textbox Params
textboxWidth = 400;
textboxHeight = 60;
border = 8;
lineSep = 15;
lineWidth = textboxWidth - border*2;
txtBSprite[0] = sprTextBoxDefault;
txtBImage = 0;
txtBImageSpeed = 4/60;


// Text Params
page = 0;
pageNumber = 0;
text[0] = "";
textLength[0] = string_length(text[0]);
char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;
drawChar = 0;
textSpeed = 1;

// Options
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

setup = false;

// Sound
snd_delay = 4;
snd_count = snd_delay;

// Effects
 scrScriptSetDefaults();
 last_free_space = 0;
 text_pause_timer = 0;
 text_pause_time = 16;