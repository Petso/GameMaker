/// @description Executes every frame
vsp = vsp + grv;

// Horizontal Collision
if (place_meeting(x + hsp, y, o_wall)) {
	while (!place_meeting(x + sign(hsp), y, o_wall)) {
		x = x + sign(hsp);
	}
	hsp = -hsp;
}
x = x + hsp;

// Vertical Collision
if (place_meeting(x, y + vsp, o_wall)) {
	while (!place_meeting(x, y + sign(vsp), o_wall)) {
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

// Animation
if (!place_meeting(x, y + 1, o_wall)) {
	sprite_index = s_enemy_air;
	image_speed = 0;
	if (sign(vsp) > 0) {
		image_index = 1;
	} else {
		image_index = 0;
	}
} else {
	image_speed = 1;
	if (hsp == 0) {
		sprite_index = s_enemy;
	} else {
		sprite_index = s_enemy_run;
	}
}
if (hsp != 0) {
	image_xscale = sign(hsp);
}