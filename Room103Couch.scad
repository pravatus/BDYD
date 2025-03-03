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

// couch dimensions in m
couch_depth=0.7;
couch_height=0.820;
couch_pillow_height=0.12;
meta_couch_size=wall_size_outer-room103_walkway_width*2-wall_thickness*2;
meta_couch_backrest_inv=couch_depth*2-couch_pillow_height*2;
couch_base_height=0.26;
couch_backrest_height=couch_height-couch_base_height-couch_pillow_height;
magic_distance=window_height/3*2+wall_size_inner/4 // strips
+seam_width*2+wall_thickness*2; // end

couch_rounding_inner1=room103_wall_rounding_outer1-room103_walkway_width-wall_thickness;
echo("couch_rounding_inner1",couch_rounding_inner1);
couch_rounding_inner2=wall_rounding_outer-room103_walkway_width-wall_thickness;
echo("couch_rounding_inner2",couch_rounding_inner2);

module couch_base_top() {
    translate([0,0,couch_base_height/2]) rect_tube(size=meta_couch_size,wall=couch_depth
        ,rounding=[couch_rounding_inner2 // big bend
        ,couch_rounding_inner1
        ,couch_rounding_inner1
        ,couch_rounding_inner1] // other couch
        ,ichamfer=[couch_rounding_inner2-couch_depth // big bend
        ,couch_rounding_inner1-wall_thickness
        ,couch_rounding_inner1-wall_thickness
        ,couch_rounding_inner1-wall_thickness] // other couch
        ,h=(couch_base_height/2)-seam_width);
}

module base_top_led() {
    translate([0,0,couch_base_height-seam_width*2]) rect_tube(size=meta_couch_size,wall=couch_depth-seam_depth
        ,rounding=[couch_rounding_inner2 // big bend
        ,couch_rounding_inner1
        ,couch_rounding_inner1
        ,couch_rounding_inner1] // other couch
        ,ichamfer=[couch_rounding_inner2-couch_depth+seam_depth // big bend
        ,couch_rounding_inner1-wall_thickness+seam_depth
        ,couch_rounding_inner1-wall_thickness+seam_depth
        ,couch_rounding_inner1-wall_thickness+seam_depth] // other couch
        ,h=seam_width*2);
}

module couch_pillow_backrest() {
    translate([0,0,couch_base_height+couch_pillow_height]) rect_tube(size1=[meta_couch_size,meta_couch_size]
    ,size2=[meta_couch_size,meta_couch_size]
    ,isize1=[meta_couch_size-couch_pillow_height*3,meta_couch_size-couch_pillow_height*3] // lumbar support lol
    ,isize2=[meta_couch_size-couch_pillow_height*2,meta_couch_size-couch_pillow_height*2]
    ,rounding=[couch_rounding_inner2 // big bend
    ,couch_rounding_inner1
    ,couch_rounding_inner1
    ,couch_rounding_inner1] // other couch
    ,h=couch_backrest_height);
}

module couch_pillow_seat() {
    translate([0,0,couch_base_height]) rect_tube(size=meta_couch_size,wall=couch_depth
    ,rounding=[couch_rounding_inner2 // big bend
    ,couch_rounding_inner1
    ,couch_rounding_inner1
    ,couch_rounding_inner1] // other couch
    ,ichamfer=[couch_rounding_inner2-couch_depth // big bend
    ,couch_rounding_inner1-wall_thickness
    ,couch_rounding_inner1-wall_thickness
    ,couch_rounding_inner1-wall_thickness] // other couch
    ,h=couch_pillow_height);
}

module couch_base_cut() { 
    translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0]) 
        cuboid([4,
            magic_distance+wall_thickness*4,
            2]);

    mirror([1,0,0]) translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0]) 
        cuboid([4,
            magic_distance+wall_thickness*4,
            2]);

    translate([0,
        wall_size_outer/2-2,
        0]) 
        cuboid([wall_thickness*5,
            4,
            2]);
        
    translate([0,
        -wall_size_outer/2+2,
        0]) 
        cuboid([wall_thickness*5,
            4,
            2]);
}

module pillow_cuts_small_corner() {
    // small corner 
    translate([meta_couch_size/2-room103_wall_rounding_outer1+room103_walkway_width-wall_thickness*1.5
        ,-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5
        ,0])
        cuboid([15
            ,seam_depth
            ,2]);

    // small corner
    translate([meta_couch_size/2-room103_wall_rounding_outer1+room103_walkway_width-wall_thickness*1.5
        ,-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5
        ,0])
        rotate([0,0,45]) cuboid([seam_depth
            ,15
            ,2]);

    // small corner
    translate([meta_couch_size/2-room103_wall_rounding_outer1+room103_walkway_width-wall_thickness*1.5
        ,-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5
        ,0])
        cuboid([seam_depth
            ,15
            ,2]);

    // small mid section
    translate([(meta_couch_size/2-room103_wall_rounding_outer1+room103_walkway_width-wall_thickness*1.5)/2
    +(wall_thickness*2.5+couch_depth)/2
        ,-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5 // end-table
        ,0])
        cuboid([seam_depth
            ,15
            ,2]);
}

module pillow_cuts_big_corner() {
    // corner cut
    translate([meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,0])
        cuboid([15,
            ,seam_depth
            ,2]);

    // corner cut
    translate([meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,0])
        cuboid([seam_depth,
            ,15
            ,2]);

    // big corner cuts
    translate([meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,0])
        rotate([0,0,-45]) cuboid([seam_depth,
            ,15
            ,2]);

    // big corner cuts
    translate([meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,0])
        rotate([0,0,-22.5]) cuboid([seam_depth,
            ,15
            ,2]);

    // big corner cuts
    translate([meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,meta_couch_size/2-wall_rounding_outer+room103_walkway_width+wall_thickness
        ,0])
        rotate([0,0,-67.5]) cuboid([seam_depth,
            ,15
            ,2]);
}

module couch_end_tables() { 
    translate([wall_size_outer/2-2,
        -wall_size_inner/8+0.5,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*couch_depth-1,
            1]);

    mirror([1,0,0]) translate([wall_size_outer/2-2,
        -wall_size_inner/8+0.5,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*couch_depth-1,
            1]);

    translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*seam_depth,
            1]);

    mirror([1,0,0]) translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*seam_depth,
            1]);

    translate([0,
        wall_size_outer/2-2,
        0.5]) 
        cuboid([wall_thickness*5+2*couch_depth,
            4,
            1]);
        
    translate([0,
        -wall_size_outer/2+2,
        0.5]) 
        cuboid([wall_thickness*5+2*couch_depth,
            4,
            1]);
}

module couch_led_cut() { 
    translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*seam_depth,
            1]);

    mirror([1,0,0]) translate([wall_size_outer/2-2,
        -wall_size_inner/8,
        0.5]) 
        cuboid([4,
            magic_distance+wall_thickness*4+2*seam_depth,
            1]);

    translate([0,
        wall_size_outer/2-2,
        0.5]) 
        cuboid([wall_thickness*5+2*seam_depth,
            4,
            1]);
        
    translate([0,
        -wall_size_outer/2+2,
        0.5]) 
        cuboid([wall_thickness*5+2*seam_depth,
            4,
            1]);
}

module couch_base_geom() {
    difference() {
        couch_base_top();
        couch_base_cut();
    }

    difference() {
        base_top_led();
        couch_led_cut();
    }
}

module pillow_geom() {
    couch_pillow_backrest();
    couch_pillow_seat();
}

module pillow_cut_geom() {
    couch_end_tables();
    pillow_cuts_big_corner();
    pillow_cuts_small_corner();
    mirror([1,0,0]) pillow_cuts_small_corner();
    mirror([0,1,0]) mirror([1,0,0]) pillow_cuts_small_corner();
    
    right_magic=-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5;
    left_magic=-(magic_distance+wall_thickness*4+2*couch_depth-wall_size_inner/4)/2;
    magic_add=(-right_magic+left_magic)/2;
    magic_offset=left_magic-magic_add;
    mirror([1,0,0]) mirror([0,1,0]) translate([meta_couch_size/2-room103_wall_rounding_outer1+room103_walkway_width-wall_thickness*1.5
        //,-meta_couch_size/2+room103_wall_rounding_outer1-room103_walkway_width+wall_thickness*1.5
        ,magic_offset
        ,0])
        cuboid([15
            ,seam_depth
            ,2]);
}

module pillow_geom_cut() {
    difference() {
        pillow_geom();
        pillow_cut_geom();
    }
}

//couch_base_geom();
//pillow_geom_cut();
