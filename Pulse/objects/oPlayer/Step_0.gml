/// @description Insert description here
// Keyboard Controls
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);
key_jump_held = keyboard_check(vk_space)

// Gamepad Controls
if (abs(gamepad_axis_value(0, gp_axislh)) > 0.2) {
	key_left = abs(min(gamepad_axis_value(0, gp_axislh), 0));
	key_right = max(gamepad_axis_value(0, gp_axislh), 0);
}
if (gamepad_button_check(0, gp_face1)) {
	key_jump = 1;
	key_jump_held = 1;
}

// Horizontal Acceleration and Movement Calculations
if (key_right) {
	if (hsp < hsp_max - accel) hsp += accel;
	if (hsp >= hsp_max - accel) hsp = hsp_max;
}
if (key_left){
    if (hsp > -hsp_max + accel) hsp -= accel;
    if (hsp <= -hsp_max + accel) hsp = -hsp_max;
    }
if (!key_right && !key_left) || (key_right && key_left) {
    if (hsp >= decel) hsp -= decel;
    if (hsp <= -decel) hsp += decel;
    if (hsp > -decel) && (hsp < decel) hsp = 0;
}

// Jump Controls
// FIXME: 
if (place_meeting(x, y + 1, oWall)) {
	vsp = key_jump * -jumpspeed;
}
if (vsp < 0) && (!key_jump_held) {
	vsp = max(vsp, -shorthopfriction)
}

// Vertical Acceleration and Movement Calculations
// FIXME:
if (vsp < fallspeed) {
	vsp = vsp + grv;
}


// Horizontal Collision
if (place_meeting(x + hsp, y, oWall)) {
	while (!place_meeting(x + sign(hsp), y, oWall)) {
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

// Vertical Collision
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x, y + sign(vsp), oWall)) {
			y = y + sign(vsp);
		}
		vsp = 0;
	}
	y = y + vsp;

// Animation
if (hsp != 0) {
	image_xscale = sign(hsp);
}