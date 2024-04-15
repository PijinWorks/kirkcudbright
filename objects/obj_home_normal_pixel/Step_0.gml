if  room == rm_scylla_bedroom && obj_scylla.x = 350 && sprite_alive = true
	{
		draw_sprite_tiled(sprite_index, image_index, 0, 0)
		 image_alpha-=0.05; //change this to affect the fading speed
	}
else
	{
		image_alpha < 0 instance_destroy();
		sprite_alive = false;
		}