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
include <Door1.scad>
include <WallSconce1.scad>
include <WallSconce2.scad>

module outer_wall_geom() {
    translate([0,0,-wall_thickness]) 
    rect_tube(size=wall_size_outer
        ,wall=wall_thickness
        ,rounding=wall_rounding_outer
        ,h=wall_height);
}

module outer_wall_cutouts() {
    // punch door holes
    translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) door_hole_punch();
    rotate([0,0,90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) door_hole_punch();
    rotate([0,0,180]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) door_hole_punch();
    rotate([0,0,-90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) door_hole_punch();
    
    // door led punch
    translate([wall_size_outer/2+-wall_thickness
        +(wall_thickness/2-(door_leaf_outside_thickness+door_leaf_inside_thickness)/2)/2
        ,wall_size_inner/8,0]) 
        door_led_punch();
    rotate([0,0,90]) translate([wall_size_outer/2+-wall_thickness
        +(wall_thickness/2-(door_leaf_outside_thickness+door_leaf_inside_thickness)/2)/2
        ,wall_size_inner/8,0]) 
        door_led_punch();
    rotate([0,0,180]) translate([wall_size_outer/2+-wall_thickness
        +(wall_thickness/2-(door_leaf_outside_thickness+door_leaf_inside_thickness)/2)/2
        ,wall_size_inner/8,0]) 
        door_led_punch();
    rotate([0,0,-90]) translate([wall_size_outer/2+-wall_thickness
        +(wall_thickness/2-(door_leaf_outside_thickness+door_leaf_inside_thickness)/2)/2
        ,wall_size_inner/8,0]) 
        door_led_punch();
}

module sconce1(number) {
    translate([-wall_size_inner/8+door_leaf_width/2+door_frame_width+wall_sconce1_width+0.3
        ,wall_size_outer/2-wall_thickness
        ,1.70]) wall_sconce1();
    translate([-wall_size_inner/8-door_leaf_width/2-door_frame_width-wall_sconce1_width-0.3
        ,wall_size_outer/2-wall_thickness
        ,1.70]) wall_sconce1();
    translate([-wall_size_inner/8+door_leaf_width/2+door_frame_width+wall_sconce1_width+0.3
        ,wall_size_outer/2-wall_thickness
        ,1.70]) apt_no(number);
}

module sconce2() {
    translate([-wall_size_inner/8,wall_size_inner/2,corridor_height/2]) rotate([-90,0,0]) wall_sconce2();
}

module outer_wall_extras() {
    // posts
    translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_posts();
    rotate([0,0,90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_posts();
    rotate([0,0,180]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_posts();
    rotate([0,0,-90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_posts();
    
    // doors
    translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_door();
    rotate([0,0,90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_door();
    rotate([0,0,180]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_door();
    rotate([0,0,-90]) translate([wall_size_outer/2-wall_thickness/2,wall_size_inner/8,0]) the_door();
    
    // sconces
    sconce1("104");
    rotate([0,0,90]) sconce1("103");
    rotate([0,0,180]) sconce1("102");
    rotate([0,0,-90]) sconce1("101");
}

module outer_wall_assembly() {
    difference() {
        outer_wall_geom();
        outer_wall_cutouts();
    }
    
    // SLOW
    outer_wall_extras();
}

module inner_wall_outer_layer() {
    difference() {
        translate([0,0,-wall_thickness]) 
            rect_tube(size=wall_size_inner,wall=wall_thickness-seam_depth,rounding=wall_rounding_inner,h=wall_height);
        translate([wall_size_inner/2,wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner,wall_size_inner/2,window_height],rounding=window_height/3);
        translate([-wall_size_inner/2,wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner/2,wall_size_inner, window_height],rounding=window_height/3);
        translate([wall_size_inner/2,-wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner/2,wall_size_inner, window_height],rounding=window_height/3);
        translate([-wall_size_inner/2,-wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner,wall_size_inner/2,window_height],rounding=window_height/3);
    }
}

module inner_wall_inner_layer() {
    difference() {
        translate([0,0,-wall_thickness]) 
            rect_tube(size=wall_size_inner-wall_thickness*2+seam_depth*2,wall=seam_depth,rounding=wall_rounding_inner-wall_thickness+seam_depth, h=wall_height);
        translate([wall_size_inner/2,wall_size_inner/2,corridor_height/2])
            cuboid([wall_size_inner+seam_width*2,wall_size_inner/2+seam_width*2,window_height+seam_width*2],rounding=window_height/3+seam_width);
        translate([-wall_size_inner/2,wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner/2+seam_width*2,wall_size_inner+seam_width*2,window_height+seam_width*2],rounding=window_height/3+seam_width);
        translate([wall_size_inner/2,-wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner/2+seam_width*2,wall_size_inner+seam_width*2,window_height+seam_width*2],rounding=window_height/3+seam_width);
        translate([-wall_size_inner/2,-wall_size_inner/2,corridor_height/2]) 
            cuboid([wall_size_inner+seam_width*2,wall_size_inner/2+seam_width*2,window_height+seam_width*2],rounding=window_height/3+seam_width);
    }
}

module walkway_floor() {
    translate([0,0,-wall_thickness])
        rect_tube(size=wall_size_outer
            ,wall=floor_width
            ,rounding=wall_rounding_outer
            ,irounding=floor_rounding_inner
            ,h=wall_thickness);
}

module walkway_ceiling() {
    translate([0,0,corridor_height]) 
    difference() { 
        rect_tube(size=wall_size_outer
            ,wall=floor_width
            ,rounding=wall_rounding_outer
            ,irounding=floor_rounding_inner
            ,h=wall_thickness);
        ceiling_rail_led();
    }
}

module ceiling_rail_led() {
	rail_led1_rounding=wall_rounding_inner+rail_led_width;
	rail_led1_size=wall_size_inner+rail_led_width*2;
	rect_tube(size=rail_led1_size,wall=rail_led_width,rounding=rail_led1_rounding,h=seam_depth);
	rail_led2_rounding=wall_rounding_outer-wall_thickness;
	rail_led2_size=wall_size_outer-wall_thickness*2;
	rect_tube(size=rail_led2_size,wall=rail_led_width,rounding=rail_led2_rounding,h=seam_depth);
}

module seam() {
    translate([window_height/3,seam_depth,-wall_thickness
        -wall_thickness/2]) // mesh fix
        cube([seam_width,wall_size_inner/2-wall_thickness,wall_height
        +wall_thickness]); // mesh fix
    translate([window_height/3,wall_size_inner/4,corridor_height/2-window_height/2-seam_depth]) 
        cube([seam_width,wall_size_inner/3,window_height+seam_depth*2]);
    translate([-wall_size_inner/4-window_height/3-seam_width,seam_depth,-wall_thickness
        -wall_thickness/2]) 
        cube([seam_width,wall_size_inner/2-wall_thickness,wall_height
        +wall_thickness]); // mesh fix
    translate([-wall_size_inner/4-window_height/3-seam_width,wall_size_inner/4,corridor_height/2-window_height/2-seam_depth])
        cube([seam_width,wall_size_inner/3,window_height+seam_depth*2]);
    translate([-wall_size_inner/4-window_height/3-seam_width,wall_size_inner/2-seam_depth,-seam_depth]) 
        cube([seam_width,corridor_width+2*seam_depth,corridor_height+2*seam_depth]);
    translate([window_height/3,wall_size_inner/2-seam_depth,-seam_depth]) 
        cube([seam_width,corridor_width+2*seam_depth,corridor_height+2*seam_depth]);
}

module inner_wall_assembly() {
    inner_wall_outer_layer();
    inner_wall_inner_layer();
    
    // no.2 sconces
    sconce2();
    rotate([0,0,90]) sconce2();
    rotate([0,0,180]) sconce2();
    rotate([0,0,-90]) sconce2();
}

module seams() {
    seam();
    rotate([0,0,90]) seam();
    rotate([0,0,180]) seam();
    rotate([0,0,-90]) seam();
}


// abyss cutout stuff
module abyss_led_seam_2d() {
    translate([window_height/3,seam_depth])
        square([seam_width,wall_size_inner/2-wall_thickness]);
    translate([-wall_size_inner/4-window_height/3-seam_width,seam_depth]) 
        square([seam_width,wall_size_inner/2-wall_thickness]);
}

module abyss_led_seams_2d() {
    abyss_led_seam_2d();
    rotate([0,0,90]) abyss_led_seam_2d();
    rotate([0,0,180]) abyss_led_seam_2d();
    rotate([0,0,-90]) abyss_led_seam_2d();
}

module cooltupe_endcap_led_cutout_2d() {
    difference() {
        round2d(or=wall_rounding_inner, $fn=32) 
            square([wall_size_inner,wall_size_inner], center=true);
        round2d(or=wall_rounding_inner-wall_thickness-rail_led_width, $fn=32) 
            square([wall_size_inner-wall_thickness*2-rail_led_width*2,wall_size_inner-wall_thickness*2-rail_led_width*2], center=true);
    }

    square([wall_size_inner/6,wall_size_inner/12], center=true);
    square([wall_size_inner/12,wall_size_inner/4], center=true);
}

// abyss geometry
module abyss_2d() {
    difference(){
        round2d(or=wall_rounding_inner, $fn=32) 
            square([wall_size_inner,wall_size_inner], center=true);
        round2d(or=wall_rounding_inner-wall_thickness, $fn=32) 
            square([wall_size_inner-wall_thickness*2,wall_size_inner-wall_thickness*2], center=true);
    }
}

module abyss_stamped() {
    difference() {
        linear_extrude(height=abyss_depth) abyss_2d();
        linear_extrude(height=abyss_depth+seam_depth)
            abyss_led_seams_2d();
    }
}
//abyss_stamped();

module endcap_stamped() {
    difference() {
        linear_extrude(height=wall_thickness) 
            round2d(or=wall_rounding_inner, $fn=32) 
                square([wall_size_inner,wall_size_inner], center=true);
        translate([0,0,wall_thickness-seam_depth]) linear_extrude(height=seam_depth)
            cooltupe_endcap_led_cutout_2d();
    }
}

// abyss assembly
module abyss_assembly() {
    abyss_stamped();
    endcap_stamped();
}

module the_abyss() {
    translate([0,0,abyss_depth+wall_height-wall_thickness]) mirror([0,0,1]) abyss_assembly();
    translate([0,0,-abyss_depth-wall_thickness]) abyss_assembly();
}

module walkway_geom() {
    inner_wall_assembly();
    outer_wall_assembly(); 
    walkway_floor();
    walkway_ceiling();
}

module walkway_assembly() {
    difference() {
        walkway_geom();
        seams();
    }
}

//the_abyss();
//walkway_assembly();