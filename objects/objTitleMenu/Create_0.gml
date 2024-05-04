// get inputs
// controls setup
controlsSetup();

global.paused = false;
global.fontTitle = draw_set_font(ftFibberish);

width = 64;
height = 104;

opBorder = 8;
opSpace = 20;

pos = 0;

// Pause Menu
option[0, 0] = "Start Game";
option[0, 1] = "Load Game";
option[0, 2] = "Gallery";
option[0, 3] = "Settings";
option[0, 4] = "Quit Game";

// Settings Menu
option[3, 0] = "Window Size";
option[3, 1] = "Brightness";
option[3, 2] = "Controls";
option[3, 3] = "Back";

opLength = 0;
menuLevel = 0;