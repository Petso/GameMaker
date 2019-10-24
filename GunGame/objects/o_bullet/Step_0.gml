// Horizontal Collision Ricochet
if place_meeting(x + hspeed, y, o_wall) {
	while (!place_meeting(x + sign(hspeed), y, o_wall)) {
		x = x + sign(hspeed);
	}
	if ricochet > 0 {
		if direction > 0 && direction < 90 {
			direction = wrap(direction + 2 * (90 - direction), 0, 359);
		} else if direction > 90 && direction < 180 {
			direction = wrap(direction - 2 * (direction - 90), 0, 359);
		} else if direction > 180 && direction < 270 {
			direction = wrap(direction + 2 * (270 - direction), 0, 359);
		} else if direction > 270 && direction < 360 {
			direction = wrap(direction - 2 * (direction - 270), 0, 359);
		}
		image_angle = direction;
		ricochet --;
	} else {
		instance_destroy();
	}
}

// Vertical Collision Ricochet
if place_meeting(x, y + vspeed, o_wall) {
	while (!place_meeting(x, y + sign(vspeed), o_wall)) {
		y = y + sign(vspeed);
	}
	if ricochet > 0 {
		if direction > 0 && direction < 90 {
			direction = wrap(direction - 2 * direction, 0, 359);
		} else if direction > 90 && direction < 180 {
			direction = wrap(direction + 2 * (180 - direction), 0, 359);
		} else if direction > 180 && direction < 270 {
			direction = wrap(direction - 2 * (direction - 180), 0, 359);
		} else if direction > 270 && direction < 360 {
			direction = wrap(direction + 2 * (360 - direction), 0, 359);
		} else {
			direction += 180;	
		}
		image_angle = direction;
		ricochet --;
	} else {
		instance_destroy();
	}
}
