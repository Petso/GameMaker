if (hp <= 0){
	with(instance_create_layer(x, y, layer, o_enemy_dead)){
		// Death Physics
		direction = other.hit_dir;
		hsp = lengthdir_x(3, direction);
		vsp = lengthdir_y(3, direction) - 2;
		// Sprite Direction
		if (sign(hsp) != 0) {
			image_xscale = sign(hsp);
		}
	}
	instance_destroy();
}