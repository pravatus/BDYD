// This file is part of "BDYD?".
//
// "BDYD?" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License 
// as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later 
// version.
//
// "BDYD?" is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied 
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more 
// details.

// You should have received a copy of the GNU General Public License along with "BDYD?". If not, see 
// <https://www.gnu.org/licenses/>. 

include <../BOSL2/std.scad>

$fn = 30; // segments in a circle (360/30 = 12 degrees)
//$fn = 8; // low poly truss

phi=(1 + sqrt(5)) / 2;

mesh_fix=0.002;
seam_depth=0.005;
seam_width=0.02;
wall_thickness=0.2;