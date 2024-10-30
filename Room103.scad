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

module outer_wall_geom() {
    rect_tube(size=wall_size_outer,wall=wall_thickness
       ,rounding=[room103_wall_rounding_outer2
            ,room103_wall_rounding_outer1
            ,room103_wall_rounding_outer1
            ,room103_wall_rounding_outer1]
        ,h=wall_height-wall_thickness);
    
    walkway_geom();
}

module walkway_geom() {
    difference() {
        rect_tube(size=wall_size_outer,wall=room103_walkway_width+wall_thickness
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=room103_walkway_height);
        assemble_walkway_cutout_geom();
    }
}

module assemble_walkway_cutout_geom() {
    walkway_n_floor_cutout_geom();
    walkway_cutout_geom();
    mirror([1,0,0]) walkway_cutout_geom();

    // led
    translate([0,0,room103_walkway_height-seam_width])
        rect_tube(size=wall_size_outer-room103_walkway_width*2-wall_thickness*2+seam_depth*2
            ,wall=wall_thickness
            ,rounding=[room103_wall_rounding_outer2-room103_walkway_width-wall_thickness+seam_depth
                ,room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
                ,room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
                ,room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth]
            ,h=room103_walkway_height);
}

module outer_wall_cutouts() {
    // punch door hole
    translate([wall_size_outer/2+-wall_thickness,-wall_size_inner/8,0]) door_hole_punch();
    
    // door led punch
    mirror([0,1,0]) translate([wall_size_outer/2+-wall_thickness
        +(wall_thickness/2-(door_leaf_outside_thickness+door_leaf_inside_thickness)/2)/2
        ,wall_size_inner/8
        ,0])
        door_led_punch();
}

module outer_wall_extras() {
    // posts
    translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) the_posts();   
 
    // door
    translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) the_door();
    
    // TODO: sconces
}

module room103_geom() {
    outer_wall_geom();
    floor_geom();
    //ceiling_geom();
}

module ceiling_geom() {
    translate([0,0,corridor_height]) 
        prismoid(wall_size_outer,wall_size_outer
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=wall_thickness);
}

module floor_geom() {
    difference() {
        translate([0,0,-wall_thickness]) prismoid(wall_size_outer,wall_size_outer
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=wall_thickness*2); // +1 wall because cutouts
        walkway_n_floor_cutout_geom();
    }
}

module room103_assembly() {
    difference() {
        room103_geom();
        outer_wall_cutouts();
        // SLOW
        //floor_cutouts();
    }
    
    // SLOW
    //outer_wall_extras();
}

module floor_cutouts() {
    difference() {
        floor_cutout_geom();
        outer_wall_geom();
    }
}

module floor_cutout_geom() {
    translate([wall_size_outer/4+wall_thickness/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width-wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[RIGHT,TOP,BOT,FRONT]);

    // led strip
    translate([wall_size_outer/4+wall_thickness/2-seam_depth/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width+seam_depth/2-wall_thickness
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[RIGHT,TOP,BOT,FRONT]);

    translate([-wall_size_outer/4-wall_thickness/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width-wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[LEFT,TOP,BOT,FRONT]);

    // led strip
    translate([-wall_size_outer/4-wall_thickness/2+seam_depth/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width+seam_depth/2-wall_thickness
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[LEFT,TOP,BOT,FRONT]);

    translate([wall_size_outer/4+wall_thickness/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[RIGHT,TOP,BOT,BACK]);

    // led strip
    translate([wall_size_outer/4+wall_thickness/2-seam_depth/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness-seam_depth/2
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[RIGHT,TOP,BOT,BACK]);

    translate([-wall_size_outer/4-wall_thickness/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[LEFT,TOP,BOT,BACK]);

    // led strip
    translate([-wall_size_outer/4-wall_thickness/2+seam_depth/2,
        wall_size_outer/4+window_height/3+seam_width+wall_thickness-seam_depth/2
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[LEFT,TOP,BOT,BACK]);
}

module walkway_n_floor_cutout_geom() {
    // mudroom
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*2]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*4
            ,room103_walkway_height
    ]);
    
    // leds
    walkway_n_floor_led_cutout_geom();
}

module walkway_n_floor_led_cutout_geom() {
    // mudroom
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*3-seam_width]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness+seam_depth*2
            ,door_frame_top_width+stair_run*4+seam_depth*2
            ,room103_walkway_height
    ]);

}

module walkway_cutout_geom() {
    // step 0
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*2]) // not elevated
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*6
            ,room103_walkway_height
    ]);
    
    // step 1
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*4]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*8
            ,room103_walkway_height
    ]);
    
    // step 2
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*5]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*10
            ,room103_walkway_height
    ]);
    
    // leds
    walkway_led_cutout_geom();
}

module walkway_led_cutout_geom() {
    // step 0
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*4-seam_width])
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*6+seam_depth*2
            ,room103_walkway_height
    ]);
    
    // step 1
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*5-seam_width]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*8+seam_depth*2
            ,room103_walkway_height
    ]);
    
    // step 2
    translate([wall_size_outer/2-room103_walkway_width/2-stair_run/2-wall_thickness/2
        ,-wall_size_inner/8
        ,wall_thickness*6-seam_width]) 
        cuboid([room103_walkway_width+stair_run+wall_thickness
            ,door_frame_top_width+stair_run*10+seam_depth*2
            ,room103_walkway_height
    ]);
}

room103_assembly();