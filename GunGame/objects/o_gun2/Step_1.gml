/// @description Executes before any steps happens
if instance_exists(o_player2) {
	x = o_player2.x;
	y = o_player2.y + 10;

	if (o_player2.controller == 0) {
		image_angle = point_direction(x, y, mouse_x, mouse_y);
	} else {
		var controllerh = gamepad_axis_value(1, gp_axisrh);
		var controllerv = gamepad_axis_value(1, gp_axisrv);
		if (abs(controllerh) > 0.2 || abs(controllerv) > 0.2) {
			controllerangle = point_direction(0, 0, controllerh, controllerv);
		}
		image_angle = controllerangle;
	}

	// Adjusted Instance Variables
	firingdelay = firingdelay - 1;
	recoil = max(0, recoil - 1);

	// Shooting
	if (mouse_check_button(mb_left) || gamepad_button_check(1, gp_shoulderrb)) && (firingdelay < 0) {
		firingdelay = 60;
		recoil = 4;
		if image_angle > 70 && image_angle < 110 {
			with(instance_create_layer(x, y - 10, "Bullets", o_bullet)) {
				speed = 25;
				direction = other.image_angle + random_range(-3, 3);
				image_angle = direction;
			}
		} else {
			with(instance_create_layer(x, y, "Bullets", o_bullet)) {
				speed = 25;
				direction = other.image_angle + random_range(-3, 3);
				image_angle = direction;
			}
		}
	}

	// Recoil Animation
	x = x - lengthdir_x(recoil, image_angle);
	y = y - lengthdir_y(recoil, image_angle);

	// Flipping gun direction
	if (image_angle > 90 && image_angle < 270) {
		image_yscale = -1;
	} else {
		image_yscale = 1;
	}
} else {
	instance_destroy();
}