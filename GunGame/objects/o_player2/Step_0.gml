/// @description Executes every frame
// Player Input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_jump = keyboard_check_pressed(vk_space) || keyboard_check(ord("W"));

if (key_left || key_right || key_jump) {
	controller = 0;
}

if (abs(gamepad_axis_value(1, gp_axislh)) > 0.2) {
	key_left = abs(min(gamepad_axis_value(1, gp_axislh), 0));
	key_right = max(gamepad_axis_value(1, gp_axislh), 0);
	controller = 1;
}
if (gamepad_button_check_pressed(1, gp_shoulderlb)) {
	key_jump = 1;
	controller = 1;
}

// Movement Calculation
var move = key_right - key_left; //temporary variable lasts one frame
hsp = move * walksp;
vsp = vsp + grv;

// Jump
if	(place_meeting(x, y + 1, o_wall) && key_jump) {
	vsp = -15;
}

// Horizontal Collision
if (place_meeting(x + hsp, y, o_wall)) {
	while (!place_meeting(x + sign(hsp), y, o_wall)) {
		x = x + sign(hsp);
	}
	hsp = 0;
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