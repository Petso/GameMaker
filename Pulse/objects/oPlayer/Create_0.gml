/// @description
// Horizontal Physics
hsp = 0;
hsp_frac = 0;
hsp_acc = 1;
hsp_fric_ground = 0.5;
hsp_fric_air = 0.15;
hsp_walk = 4;
hsp_wjump = 4;

// Vertical Physics
vsp_frac = 0;
vsp_max = 10;
vsp = 0;
vsp_jump = -8;
vsp_wjump = -5;
vsp_max_wall = 4;

grv = 0.3;
grv_wall = 0.1;

fallspeed = 8;
jumpspeed = 12;
shorthopfriction = -jumpspeed / 5;
jumpexpired = true;
jumpbuffer = 0;
walljumpdelay = 0;
walljumpdelay_max = 15;

// Other
dead = false;
onground = false;
onwall = 0;
dust = 0;


global.reverseGrav = false;