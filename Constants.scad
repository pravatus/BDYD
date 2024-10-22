include <../BOSL2/std.scad>

$fn = 30; // segments in a circle (360/30 = 12 degrees)
//$fn = 8;

phi=(1 + sqrt(5)) / 2;

mesh_fix=0.002;
seam_depth=0.005;
seam_width=0.02;
wall_thickness=0.2;