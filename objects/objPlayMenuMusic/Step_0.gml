if (room == rmTitleScreen) {
	audio_play_sound(menuMemoriesOfYou, 10, true);
} else {
	if (audio_is_playing(menuMemoriesOfYou)) {
	audio_stop_sound(menuMemoriesOfYou);
	}
}
	
	