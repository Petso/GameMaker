/// @description
// Keyboard Controls
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);
key_jump_held = keyboard_check(vk_space);
key_wall_grab = keyboard_check(vk_shift);
key_switch_grav = keyboard_check_pressed(ord("D"));

// Gravity Settings
//if (key_switch_grav) {
//	vsp_max = -1 * vsp_max;
//	vsp_jump = -1 * vsp_jump;
//	vsp_wjump = -1 * vsp_wjump;
//	vsp_max_wall = -1 * vsp_max_wall;

//	grv = -1 * grv;
//	grv_wall = -1 * grv_wall;
//	fallspeed = -1 * fallspeed;
//	jumpspeed = -1 * jumpspeed;
//	shorthopfriction = -1 * shorthopfriction;
//}
	

// Gamepad Controls
if (abs(gamepad_axis_value(0, gp_axislh)) > 0.2) {
	key_left = abs(min(gamepad_axis_value(0, gp_axislh), 0));
	key_right = max(gamepad_axis_value(0, gp_axislh), 0);
}
if (!jumpexpired && gamepad_button_check_released(0, gp_face1)) {
	jumpexpired = true;
}
if (gamepad_button_check_pressed(0, gp_face1) && jumpexpired) {
	key_jump = 1;
	jumpexpired = false;
}
if (gamepad_button_check(0, gp_face1)) {
	key_jump_held = 1;
}
// Horizontal Acceleration and Movement Calculations
//if (key_right) {
//	if (hsp < hsp_max - accel) hsp += accel;
//	if (hsp >= hsp_max - accel) hsp = hsp_max;
//}
//if (key_left){
//    if (hsp > -hsp_max + accel) hsp -= accel;
//    if (hsp <= -hsp_max + accel) hsp = -hsp_max;
//    }
//if (!key_right && !key_left) || (key_right && key_left) {
//    if (hsp >= decel) hsp -= decel;
//    if (hsp <= -decel) hsp += decel;
//    if (hsp > -decel) && (hsp < decel) hsp = 0;
//}
walljumpdelay = max(walljumpdelay - 1, 0);
if (walljumpdelay == 0) {
	var dir = key_right - key_left;
	hsp += dir * hsp_acc;
	if (dir == 0) {
		var hsp_fric_final = hsp_fric_ground;
		if (!onground) hsp_fric_final = hsp_fric_air;
		hsp = Approach(hsp, 0, hsp_fric_final);
	}
	hsp = clamp(hsp, -hsp_walk, hsp_walk);
}

// Wall Jump
if (onwall != 0) && (!onground) && (key_jump) {
	walljumpdelay = walljumpdelay_max;
	hsp = -onwall * hsp_wjump;
	vsp = vsp_wjump;
	
	hsp_frac = 0;
	vsp_frac = 0;
}

// Vertical Physics for regular gravity
if (!global.reverseGrav) {
	//if (place_meeting(x, y + 1, oWall)) {
	//	vsp = key_jump * -jumpspeed;
	//}
	//if (vsp < 0) && (!key_jump_held) {
	//	vsp = max(vsp, -shorthopfriction)
	//}
	//// Vertical Acceleration and Movement Calculations
	//if (vsp < fallspeed) {
	//	vsp = vsp + grv;
	//}
	var grv_final = grv;
	var vsp_max_final = vsp_max;
	if (onwall != 0) && (vsp > 0) {
		grv_final = grv_wall;
		vsp_max_final = vsp_max_wall;
		if (key_wall_grab) {
			vsp = 0;
		} else {
			vsp += grv;
			vsp = clamp(vsp, -vsp_max_final, vsp_max_final);
		}
	} else {
		vsp += grv;
		vsp = clamp(vsp, -vsp_max_final, vsp_max_final);
	}
	
	// Jumping
	if (jumpbuffer > 0) {
		jumpbuffer--;
		if (key_jump) {
			jumpbuffer = 0;
			vsp = vsp_jump;
			vsp_frac = 0;
		}
	}
	// Shorthopping
	if (vsp < 0) && (!key_jump_held) vsp = max(vsp, shorthopfriction)
	// Vertical Wall Collision
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x, y + sign(vsp), oWall)) {
			y = y + sign(vsp);
		}
		vsp = 0;
	}
	// Vertical Move
	y = y + vsp;
}
// Vertical Physics for reverse gravity
if (global.reverseGrav) {
	//TODO:
}

// Dump fractions and get final integer speeds
hsp += hsp_frac;
vsp += vsp_frac;
hsp_frac = frac(hsp);
vsp_frac = frac(vsp);
hsp -= hsp_frac;
vsp -= vsp_frac;

// Horizontal Wall Collision
if (place_meeting(x + hsp, y, oWall)) {
	while (!place_meeting(x + sign(hsp), y, oWall)) {
		x = x + sign(hsp);
	}
	hsp = 0;
}
// Horizontal Move
x = x + hsp;

//Calc current status
onground = place_meeting(x, y + 1, oWall);
onwall = place_meeting(x+1, y, oWall) - place_meeting(x-1, y, oWall);
if (onground) jumpbuffer = 6;

// Death State
if (place_meeting(x, y, oDeath)) {
	dead = true;
}
if (dead) {
	instance_destroy();
}

// Animations
image_speed = 1;
if (!place_meeting(x, y + 1, oWall)) {
	sprite_index = sPlayer;
}
else
{
	image_speed = 1;
	if (hsp == 0) {
		sprite_index = sPlayer;
	}
	else
	{
		sprite_index = sPlayerRun;
	}
}
if (hsp != 0) {
	image_xscale = sign(hsp);
}
if (!onground) {
	if (onwall != 0) {
		//sprite_index = sPlayer_wall;
		//image_xscale = onwall;
		var side = bbox_left;
		if (onwall == 1) side = bbox_right;
		dust++;
		if ((dust > 2) && (vsp > 0)) with (instance_create_layer(side, bbox_top, "Behind", oDust)) {
			other.dust = 0;
			hspeed = -other.onwall * 0.5;
		}
	} else {
		dust = 0;
		// TODO: Add falling animation
		//sprite_index = sPlayer_air;
		//image_speed = 0;
		//image_index = 0;
	}
}
	