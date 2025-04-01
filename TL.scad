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

include <Constants.scad>

tl_fixture_tl_l=1.22;
tl_fixture_tl_w=0.0254;
tl_fixture_w=0.112;
tl_fixture_h=0.054;
tl_fixture_wall=0.005;
tl_fixture_l=tl_fixture_wall*4+tl_fixture_tl_l;

module half_tl() {
difference() {
    rect_tube(size=[tl_fixture_l,tl_fixture_w/2], wall=tl_fixture_wall, h=tl_fixture_h);
    translate([0,-tl_fixture_h/2,tl_fixture_h+tl_fixture_wall*1]) 
        rotate([40,0,0]) 
            cube([tl_fixture_l+0.002,tl_fixture_w,tl_fixture_h], center=true);
    
    translate([0,0,tl_fixture_h/2+tl_fixture_wall*3+tl_fixture_tl_w])
        cube([tl_fixture_l+0.002,tl_fixture_w,tl_fixture_h], center=true);
    
    translate([0,-tl_fixture_w/2,tl_fixture_h/2+tl_fixture_wall*2+tl_fixture_tl_w/4])
        cube([tl_fixture_l-tl_fixture_wall*2,tl_fixture_w,tl_fixture_h], center=true);
}

translate([0,0,tl_fixture_tl_w/2+tl_fixture_wall*2])
    rotate([0,90,0]) cyl(d=tl_fixture_tl_w, l=tl_fixture_tl_l, chamfer=tl_fixture_tl_w/10, $fn=8);

translate([0,0,tl_fixture_wall/2])
    cube([tl_fixture_l,tl_fixture_w/2,tl_fixture_wall+0.002], center=true);
}

module build_tl() {
    translate([0,-tl_fixture_w/4+tl_fixture_wall/2,0]) half_tl();
    translate([0,tl_fixture_w/4-tl_fixture_wall/2,0]) mirror([0,1,0]) half_tl();
}

//build_tl();