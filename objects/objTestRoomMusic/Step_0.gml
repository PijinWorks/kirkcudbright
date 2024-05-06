if (room == rmTestRoom0 || rmTestRoom1 || rmTestRoom2) {
	audio_play_sound(sndDownTheRabbitHole, 8, true);
} else {
	if (audio_is_playing(sndDownTheRabbitHole)) {
	audio_stop_sound(sndDownTheRabbitHole);
	}
}
	
	