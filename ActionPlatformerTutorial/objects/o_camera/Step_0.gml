/// @description Update camera

// Update destination
if (instance_exists(follow)) {
	xTo = follow.x;
	yTo = follow.y;
}

// Update obj position
x += (xTo - x) / 25;
y += (yTo - y) / 25;

// Keep the camera in the room
x = clamp(x, view_w_half, room_width - view_w_half);
y = clamp(y, view_h_half, room_height - view_h_half);

// Update camera view
camera_set_view_pos(cam, x - view_w_half, y - view_h_half);
