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
include <WallSconce2.scad>
include <Room103Couch.scad>

module outer_wall_geom() {
    rect_tube(size=wall_size_outer,wall=wall_thickness
       ,rounding=[room103_wall_rounding_outer2
            ,room103_wall_rounding_outer1
            ,room103_wall_rounding_outer1
            ,room103_wall_rounding_outer1]
        ,h=wall_height-wall_thickness);
    outer_wall_slope(); 
}

module outer_wall_geom_assembly() {
    outer_wall_geom();
    walkway_geom_assembly();
}

module sconces() {
    rotate([0,0,90]) 
        mirror([0,1,0]) 
            translate([-wall_size_inner/8+door_leaf_width/2+door_frame_width+wall_sconce2_lamp_width+0.3
                ,wall_size_outer/2-wall_thickness
                ,1.70])
                rotate([90,0,0])
                    wall_sconce2();
    rotate([0,0,90])
        mirror([0,1,0]) 
            translate([-wall_size_inner/8-door_leaf_width/2-door_frame_width-wall_sconce2_lamp_width-0.3
                ,wall_size_outer/2-wall_thickness
                ,1.70])
                rotate([90,0,0])
                    wall_sconce2();
        
    translate([0,wall_size_outer/2-wall_thickness,1.70+wall_thickness*4]) 
            rotate([90,0,0]) 
                wall_sconce2();

    translate([-wall_size_inner/4,0,0]) // back
        translate([0,wall_size_outer/2-wall_thickness,1.70+wall_thickness*4]) 
            rotate([90,0,0]) 
                wall_sconce2();

    translate([-wall_size_inner/4,0,0]) // back
        translate([0,-wall_size_outer/2+wall_thickness,1.70+wall_thickness*4])
            rotate([270,0,0]) 
                wall_sconce2();

    translate([wall_size_inner/4,0,0]) // back
        translate([0,-wall_size_outer/2+wall_thickness,1.70+wall_thickness*4])
            rotate([270,0,0])
                wall_sconce2();

    mirror([1,1,0])
        translate([-wall_size_inner/4,0,0]) // back
            translate([0,wall_size_outer/2-wall_thickness,1.70+wall_thickness*4])
                rotate([90,0,0])
                    wall_sconce2();
}

module outer_wall_slope() {
    translate([0,0,wall_height-room_103_outer_wall_slope_height-wall_thickness*2+seam_depth+mesh_fix]) 
        rect_tube(size1=[wall_size_outer,wall_size_outer] // bottom
            ,size2=[wall_size_outer,wall_size_outer] // top
            ,isize1=[wall_size_outer-wall_thickness*2+0.05,wall_size_outer-wall_thickness*2+0.05]
            ,isize2=[wall_size_outer-wall_thickness*4,wall_size_outer-wall_thickness*4],
            ,wall=wall_thickness*2
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=room_103_outer_wall_slope_height);
}

module walkway_geom() {
    rect_tube(size=wall_size_outer,wall=room103_walkway_width+wall_thickness
        ,rounding=[room103_wall_rounding_outer2
        ,room103_wall_rounding_outer1
        ,room103_wall_rounding_outer1
        ,room103_wall_rounding_outer1]
        ,h=room103_walkway_height);
}

module walkway_geom_assembly() {
    difference() {
        walkway_geom();
        assemble_walkway_cutout_geom_assembly();
    }
}

module assemble_walkway_cutout_geom_assembly() {
    walkway_n_floor_cutout_geom_assembly();
    walkway_cutout_geom_assembly();
    mirror([1,0,0]) walkway_cutout_geom_assembly();

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
    translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) the_posts();   
    translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) the_door();
    sconces();
}

module room103_geom() {
    outer_wall_geom_assembly();
    floor_geom();
    // DEBUG
    //ceiling_assembly();
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

module ceiling_assembly() {
    difference() {
        ceiling_geom();
        mirror([0,1,0]) rotate([0,0,90]) led_seam();
        translate([0,0,corridor_height]) rail_light();
    }
}

module floor_geom() {
    difference() {
        translate([0,0,-wall_thickness]) prismoid(wall_size_outer,wall_size_outer
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=wall_thickness*2); // +1 wall because cutouts
        walkway_n_floor_cutout_geom_assembly();
    }
}

module floor_collider_geom() {
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

module floor_cutout_geom_assembly() {
    floor_cutout_geom();
    floor_cutout_led_geom();
}

module floor_cutouts() {
    difference() {
        floor_cutout_geom_assembly();
        outer_wall_geom_assembly();
    }
}

module floor_cutout_geom() {
    translate([wall_size_outer/4+wall_thickness/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width-wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[RIGHT,TOP,BOT,FRONT]);

    translate([-wall_size_outer/4-wall_thickness/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width-wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[LEFT,TOP,BOT,FRONT]);

    translate([wall_size_outer/4+wall_thickness/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[RIGHT,TOP,BOT,BACK]);

    translate([-wall_size_outer/4-wall_thickness/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness
        ,wall_thickness])
        cuboid([wall_size_outer/2,wall_size_outer/2,wall_thickness*2]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness
            ,except=[LEFT,TOP,BOT,BACK]);
}

module floor_cutout_led_geom() {
    // led strip
    translate([wall_size_outer/4+wall_thickness/2-seam_depth/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width+seam_depth/2-wall_thickness
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[RIGHT,TOP,BOT,FRONT]);
    
    // led strip
    translate([-wall_size_outer/4-wall_thickness/2+seam_depth/2
        ,-wall_size_outer/4-wall_size_inner/4-window_height/3-seam_width+seam_depth/2-wall_thickness
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[LEFT,TOP,BOT,FRONT]);
    
    // led strip
    translate([wall_size_outer/4+wall_thickness/2-seam_depth/2
        ,wall_size_outer/4+window_height/3+seam_width+wall_thickness-seam_depth/2
        ,wall_thickness/2])
        cuboid([wall_size_outer/2+seam_depth,wall_size_outer/2+seam_depth,seam_width]
            ,rounding=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness+seam_depth
            ,except=[RIGHT,TOP,BOT,BACK]);
    
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
}

module walkway_n_floor_cutout_geom_assembly() {
    walkway_n_floor_cutout_geom();
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
}

module walkway_cutout_geom_assembly() {
    walkway_cutout_geom();
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

module led_seam_geom() {
    translate([wall_size_inner/4+window_height/3
        ,-wall_size_outer/2-seam_depth+wall_thickness
        ,-seam_depth+wall_thickness*4]) 
        cube([seam_width
            ,wall_size_outer+2*seam_depth-wall_thickness*2
            ,corridor_height+2*seam_depth-wall_thickness*4]);
    translate([-window_height/3-seam_width
        ,-wall_size_outer/2-seam_depth+wall_thickness
        ,-seam_depth+wall_thickness*4]) 
        cube([seam_width
            ,wall_size_outer+2*seam_depth-wall_thickness*2
            ,corridor_height+2*seam_depth-wall_thickness*4]);
    translate([wall_size_inner/4+window_height/3
        ,-wall_size_outer/2-seam_depth+wall_thickness+room103_walkway_width
        ,-seam_depth+wall_thickness]) 
        cube([seam_width
            ,wall_size_outer+2*seam_depth-wall_thickness*2-room103_walkway_width*2
            ,corridor_height/2]);
    translate([-window_height/3-seam_width
        ,-wall_size_outer/2-seam_depth+wall_thickness+room103_walkway_width
        ,-seam_depth+wall_thickness]) 
        cube([seam_width
            ,wall_size_outer+2*seam_depth-wall_thickness*2-room103_walkway_width*2
            ,corridor_height/2]);
}

module outer_wall_slope_seam_cutout() {
    translate([0,0,wall_height-room_103_outer_wall_slope_height-wall_thickness*2+mesh_fix+seam_depth]) 
        rect_tube(size1=[wall_size_outer,wall_size_outer] // bottom
            ,size2=[wall_size_outer,wall_size_outer] // top
            ,isize1=[wall_size_outer-wall_thickness*2+0.05,wall_size_outer-wall_thickness*2+0.05+seam_depth*2]
            ,isize2=[wall_size_outer-wall_thickness*4,wall_size_outer-wall_thickness*4+seam_depth*2],
            ,wall=wall_thickness*2
            ,rounding=[room103_wall_rounding_outer2
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1
                ,room103_wall_rounding_outer1]
            ,h=room_103_outer_wall_slope_height);
}

module led_seam() {
    difference() {
        led_seam_geom();
        outer_wall_slope_seam_cutout();
    }
}

module rail_light() {
    rail_light1_rounding=room103_wall_rounding_outer1-wall_thickness*2;
    rail_light2_rounding=room103_wall_rounding_outer2-wall_thickness*2;
    rail_light2_size=wall_size_outer-wall_thickness*4;
    rect_tube(size=rail_light2_size+seam_depth*2
        ,wall=rail_led_width
        ,rounding=[rail_light2_rounding,rail_light1_rounding,rail_light1_rounding,rail_light1_rounding]
        ,h=seam_depth);
}

module room103_rail1() {
    path = turtle3d([
        "move",wall_thickness 
        ,"arcup",wall_thickness // handle
        ,"arcup",wall_thickness
        ,"move", wall_size_outer/2-room103_walkway_width // center
            -wall_size_inner/8 // door center
            -(door_leaf_width+door_frame_width*2)/2 //door frame
            -wall_thickness // mud
            -(room103_wall_rounding_outer1-room103_walkway_width-wall_thickness) // arc
            -stair_run*5 // stairs
        ,"arcleft", room103_wall_rounding_outer1-room103_walkway_width-wall_thickness/2
        ,"move", wall_size_inner-wall_thickness*3
        ,"arcleft", room103_wall_rounding_outer1-room103_walkway_width-wall_thickness/2 // curve
        ,"move", wall_size_outer/2-room103_walkway_width // center
            -wall_size_inner/8 // door center
            -(door_leaf_width+door_frame_width*2)/2 //door frame
            -wall_thickness // mud
            -(room103_wall_rounding_outer1-room103_walkway_width-wall_thickness)
            -stair_run*5
        ,"arcup",wall_thickness
        ,"arcup",wall_thickness
        ,"move",wall_thickness
    ],transforms=true,$fn=8);

    translate([wall_size_outer/2,-wall_size_inner/8,0]) // where our door is at 
    translate([-room103_walkway_width-wall_thickness,0,1.3]) // 0 on the stair edge includes 0.4+0.9m rail h
    translate([0,(-door_leaf_width-door_frame_width*2)/2,0]) // clear door
    translate([0,-wall_thickness,0]) // clear mud room
    translate([wall_thickness/2,-stair_run*5,0]) // clear stairs
        rotate([0,0,90])
            sweep(rect([handle_width/2,handle_width],chamfer=default_chamfer),path);
}

module room103_rail2() {
    path2 = turtle3d([
        "move",wall_thickness 
        ,"arcup",wall_thickness //handle
        ,"arcup",wall_thickness
        ,"move", wall_size_outer/2-room103_walkway_width // center
        +wall_size_inner/8 // door center
            -(door_leaf_width+door_frame_width*2)/2 //door frame
            -wall_thickness // mud
            -(room103_wall_rounding_outer2-room103_walkway_width-wall_thickness) // arc
            -stair_run*5 // stairs
        ,"arcright", room103_wall_rounding_outer2-room103_walkway_width-wall_thickness/2
        ,"move", wall_size_inner-wall_thickness*3-room103_wall_rounding_outer2+room103_wall_rounding_outer1
        ,"arcright", room103_wall_rounding_outer1-room103_walkway_width-wall_thickness/2 // curve
        ,"move", wall_size_outer/2-room103_walkway_width // center
            +wall_size_inner/8 // door center
            -(door_leaf_width+door_frame_width*2)/2 //door frame
            -wall_thickness // mud
            -(room103_wall_rounding_outer1-room103_walkway_width-wall_thickness)
            -stair_run*5
        ,"arcup",wall_thickness
        ,"arcup",wall_thickness
        ,"move",wall_thickness
    ],transforms=true,$fn=8);

    translate([wall_size_outer/2,-wall_size_inner/8,0]) // where our door is at 
    translate([-room103_walkway_width-wall_thickness,0,1.3]) // 0 on the stair edge includes 0.4+0.9m rail h
    translate([0,(+door_leaf_width+door_frame_width*2)/2,0]) // clear door
    translate([0,+wall_thickness,0]) // clear mud room
    translate([wall_thickness/2,+stair_run*5,0]) // clear stairs-ish
        rotate([0,0,270]) 
            sweep(rect([handle_width/2,handle_width],chamfer=default_chamfer),path2);
}

module room103_assembly() {
    difference() {
        room103_geom();
        outer_wall_cutouts();

        // SLOW
        mirror([0,1,0]) rotate([0,0,90]) led_seam();
        floor_cutouts();
    }
    
    // SLOW
    couch_base_geom();
    outer_wall_extras();
    room103_rail1();
    room103_rail2();
}

module room103_collider() {
    difference() {
        walkway_geom();
        walkway_cutout_geom();
        mirror([1,0,0]) walkway_cutout_geom();    
    }
    // DEBUG
    //ceiling_geom();
    difference() {   
        outer_wall_geom();
        // punch door hole
        translate([wall_size_outer/2+-wall_thickness,-wall_size_inner/8,0]) door_hole_punch();
    }
    difference(){
        floor_collider_geom();
        difference() {
            floor_cutout_geom();
            outer_wall_geom_assembly();
        }
    }
    translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) door_collider();
}

//room103_assembly();
//room103_collider(); 
//translate([wall_size_outer/2-wall_thickness/2,-wall_size_inner/8,0]) the_handle_collider();