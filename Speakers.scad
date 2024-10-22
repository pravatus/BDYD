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

// woofer
woof_scale=0.1; // measurements are 10x
woof_depth=6.2;
woof_width=5.7;
woof_height=7.7;
woof_back_rounding=0.5;
woof_front_rounding=0.1;
woof_box=0.1;
woof_top_box_height=(woof_height-woof_box*5)/12*4;
echo ("woof_top_box_height",woof_top_box_height);
woof_bottom_box_hight=(woof_height-woof_box*5)/12*8;
echo ("woof_bottom_box_hight",woof_bottom_box_hight);
woof_top_box_z=3*woof_box+woof_bottom_box_hight;
echo ("woof_top_box_z",woof_top_box_z);
woof_bottom_box_z=2*woof_box;
echo ("woof_bottom_box_z",woof_bottom_box_z);
woof_box_width=woof_width-2*woof_box;
echo ("woof_box_width",woof_box_width);
woof_top_box_hole_height=woof_top_box_height/12*9;
echo ("woof_top_box_hole_height",woof_top_box_hole_height);
woof_top_box_hole_depth=4;
echo ("woof_top_box_hole_depth",woof_top_box_hole_depth);
woof_seam_depth=0.05;

// speaker

module woof_base_geom() {
    prismoid([woof_depth, woof_width],[woof_depth, woof_width]
        ,h=woof_height
        ,rounding=[woof_front_rounding,woof_back_rounding,woof_back_rounding,woof_front_rounding]);
}

module woof_cutouts() {
    // bottom box
    translate([0,0,woof_bottom_box_hight/2]) // 0
        translate([woof_depth-woof_seam_depth,0,woof_bottom_box_z])
            cuboid([woof_depth,woof_box_width,woof_bottom_box_hight]);
    
    top_box_cutout();
    
    // woofer cone
    woof_cone_width=woof_bottom_box_hight/8*6;
    woof_cone_depth=woof_cone_width/8;
    translate([woof_depth/2-woof_seam_depth-woof_cone_depth/2
        ,0
        ,woof_bottom_box_z+woof_bottom_box_hight/2])
    xcyl(l=woof_cone_depth,
        d1=woof_cone_width/3,  
        d2=woof_cone_width);
    
    // handles
    xcopies(woof_depth/6*3) 
        woof_handle();
    translate([0,0,woof_height*2]) 
        xcopies(woof_depth/6*3) 
            woof_handle();
}

module woof_handle() {
    woof_handle_height=0.3;
    translate([0,0,woof_handle_height/2-0.02]) // 0
    translate([0.4,0,0]) 
        cuboid([0.4,1,woof_handle_height],chamfer=0.15,edges=[BACK+RIGHT,FWD+RIGHT]);
    translate([0,0,woof_handle_height/2-0.02]) // 0
        translate([-0.4,0,0])
            cuboid([0.5, 1, woof_handle_height],chamfer=0.15,edges=[BACK+LEFT,FWD+LEFT]);
}

module woof() {
    difference() {
        woof_base_geom();
        woof_cutouts();
    }
}

module top_box_cutout() {
    difference() {
        // top box
        translate([0,0,woof_top_box_height/2]) // 0
            translate([woof_depth-woof_seam_depth-woof_top_box_hole_depth,0,woof_top_box_z])
                cuboid([woof_depth,woof_box_width,woof_top_box_height]);
        
        // diff
        diff() translate([0.5,0,woof_top_box_hole_height/2]) // 0
            translate([-woof_seam_depth,0,woof_top_box_z])
                cuboid([woof_depth-1,woof_box_width,woof_top_box_hole_height])
                    edge_profile([TOP+RIGHT])
                        // obtuse angle fixes double verts
                        mask2d_roundover(r=woof_top_box_hole_height, mask_angle=90.5);
    }
}

//scale(woof_scale) translate([0, woof_height/2,-woof_width/2]) rotate([90,0,0]) woof();