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

door_leaf_width=0.90;
door_leaf_hight=2.04;
door_leaf_thickness=0.06;
door_leaf_inset=0.02;
door_frame_width=0.06;
door_wiggle=0.005;
horizontal_lines=4;
horizontal_line_width=door_frame_width;
horizontal_line_height=0.001;
default_chamfer=0.002;
handle_width=0.04;

door_leaf_outside_width=door_leaf_width-door_leaf_inset*2-door_wiggle*2;
echo("door_leaf_outside_width",door_leaf_outside_width);
door_leaf_outside_height=door_leaf_hight-door_leaf_inset-door_wiggle*2;
echo("door_leaf_outside_height",door_leaf_outside_height);
door_leaf_outside_thickness=door_leaf_thickness/3*2;
echo("door_leaf_outside_thickness",door_leaf_outside_thickness);
door_leaf_inside_thickness=door_leaf_thickness/3;
echo("door_leaf_inside_thickness",door_leaf_inside_thickness);
horizontal_line_spacing=door_leaf_hight/(horizontal_lines+1);
echo("horizontal_line_spacing",horizontal_line_spacing);
handle_height=door_leaf_hight/6*3;
echo("handle_height",handle_height);
door_frame_post_height=door_leaf_hight+door_frame_width;
echo("door_frame_post_height",door_frame_post_height);


// add y and z door wiggle later
module door_base_geom() {
    cuboid([door_leaf_outside_thickness+mesh_fix,door_leaf_outside_width,door_leaf_outside_height]
        ,p1=[0,door_leaf_inset,0],chamfer=default_chamfer,edges=[LEFT],except=[BOTTOM,TOP]);
    cuboid([door_leaf_inside_thickness,door_leaf_width-2*door_wiggle,door_leaf_hight-door_wiggle*2]
        ,p1=[door_leaf_outside_thickness,0,0],chamfer=default_chamfer,except=[BOTTOM,TOP]);
}
//translate([0,door_wiggle,door_wiggle]) door_base_geom();

module stripies() {
    stripe_width=door_leaf_outside_width/5;
    echo("stripe_width",stripe_width);

    translate([0,door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*2]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*3]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*4]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);

    translate([0,stripe_width*4+door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,stripe_width*4+door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*2]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,stripe_width*4+door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*3]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([0,stripe_width*4+door_leaf_inset+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*4]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);

    translate([door_leaf_thickness-horizontal_line_height,door_wiggle,-horizontal_line_width/2+horizontal_line_spacing]) 
        cube([horizontal_line_height,door_leaf_width/5,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*2]) 
        cube([horizontal_line_height,door_leaf_width/5,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*3]) 
        cube([horizontal_line_height,door_leaf_width/5,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*4]) 
        cube([horizontal_line_height,door_leaf_width/5,horizontal_line_width]);

    translate([door_leaf_thickness-horizontal_line_height,door_leaf_width/5*4+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_leaf_width/5*4+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*2]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_leaf_width/5*4+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*3]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
    translate([door_leaf_thickness-horizontal_line_height,door_leaf_width/5*4+door_wiggle,-horizontal_line_width/2+horizontal_line_spacing*4]) 
        cube([horizontal_line_height,stripe_width,horizontal_line_width]);
}

module door_handle_grips() {
    translate([door_leaf_thickness*2,door_leaf_width/5+door_wiggle-handle_width/2,door_leaf_hight/4]) 
        cuboid([handle_width/2,handle_width,handle_height],chamfer=default_chamfer,p1=[0,0,0],except=[BOTTOM,TOP]);
    translate([-door_leaf_thickness-handle_width/2,door_leaf_width/5+door_wiggle-handle_width/2,door_leaf_hight/4]) 
        cuboid([handle_width/2,handle_width,handle_height],chamfer=default_chamfer,p1=[0,0,0],except=[BOTTOM,TOP]);
}

module handles() {
    difference() {
        translate([door_leaf_thickness/2
            ,door_leaf_width/5 //+door_wiggle
            ,door_leaf_hight/4+handle_height/10]) 
            rect_tube(size=[door_leaf_thickness*3-default_chamfer*4+handle_width,door_leaf_thickness*2+handle_width]
                ,wall=handle_width/2-default_chamfer*4
                ,h=handle_width/2-default_chamfer*2
                ,rounding=door_leaf_thickness);
        translate([-0.5,0.01+door_leaf_width/5+door_wiggle-handle_width/2,door_leaf_hight/4]) cube([1,1,handle_height]);
    }
    difference() {
        translate([door_leaf_thickness/2
            ,door_leaf_width/5 //+door_wiggle
            ,door_leaf_hight/4*3-handle_width/2+default_chamfer*2-handle_height/10]) 
            rect_tube(size=[door_leaf_thickness*3-default_chamfer*4+handle_width,door_leaf_thickness*2+handle_width]
                ,wall=handle_width/2-default_chamfer*4
                ,h=handle_width/2-default_chamfer*2
                ,rounding=door_leaf_thickness);
        translate([-0.5,0.01+door_leaf_width/5+door_wiggle-handle_width/2,door_leaf_hight/4]) cube([1,1,handle_height]);
    }

    door_handle_grips();
}

module decorated_door() {
    difference() {
        translate([0,door_wiggle,door_wiggle]) door_base_geom();
        stripies();
    }
}

module door() {
    decorated_door();
    handles();
}

module posts() {
    door_frame_post_inner_width=door_frame_width;
    door_frame_post_inner_depth=door_leaf_inside_thickness;
    translate([door_leaf_outside_thickness,door_leaf_width,-mesh_fix]) 
        cube([door_frame_post_inner_depth,door_frame_post_inner_width,door_frame_post_height+mesh_fix]);
    translate([door_leaf_outside_thickness,-door_frame_post_inner_width,-mesh_fix]) 
        cube([door_frame_post_inner_depth,door_frame_post_inner_width,door_frame_post_height+mesh_fix]);

    door_frame_post_outer_width=door_frame_width+door_leaf_inset;
    door_frame_post_outer_depth=door_leaf_outside_thickness;
    translate([0,door_leaf_width-door_leaf_inset,-mesh_fix]) 
        cube([door_frame_post_outer_depth,door_frame_post_outer_width,door_frame_post_height+mesh_fix]);
    translate([0,-door_frame_post_inner_width,-mesh_fix]) 
        cube([door_frame_post_outer_depth,door_frame_post_outer_width,door_frame_post_height+mesh_fix]);

    door_frame_top_width=door_leaf_width+door_frame_width*2;
    door_frame_top_outer_depth=door_leaf_outside_thickness;
    translate([0,-door_frame_width,door_leaf_hight-door_leaf_inset]) 
        cube([door_leaf_outside_thickness,door_frame_top_width,door_frame_post_outer_width]);

    door_frame_top_inner_width=door_leaf_width+door_frame_width*2;
    door_frame_top_inner_depth=door_leaf_inside_thickness;
    door_frame_top_inner_height=door_frame_post_outer_width-door_leaf_inset;
    translate([door_leaf_outside_thickness,-door_frame_width,door_leaf_hight]) 
        cube([door_leaf_inside_thickness,door_frame_top_width,door_frame_top_inner_height]);
}

// frame -mesh_fix so it unions
module door_hole_punch() {
    translate([0,0,door_frame_post_height/2-mesh_fix]) 
        cuboid([1,door_leaf_width+door_frame_width*2-mesh_fix,door_frame_post_height]);
}
//door_hole_punch();

module door_collider() {
translate([0,0,door_frame_post_height/2]) 
    cuboid([door_frame_width,
        door_leaf_width+door_frame_width*2,
        door_frame_post_height]);
}

module door_led_punch() {
    translate([0,0,door_frame_post_height/2+seam_depth/2]) 
    cuboid([seam_width,
        door_leaf_width+door_frame_width*2+seam_depth*2,
        door_frame_post_height+seam_depth]);
}
//door_led_punch();

module the_door() {
    translate([-door_frame_width/2,-door_leaf_width/2,0]) door();
}

module the_posts() {
    translate([-door_frame_width/2,-door_leaf_width/2,0]) posts();
}

module the_handle_collider() {
    translate([-door_frame_width/2,-door_leaf_width/2,0]) door_handle_grips();
}

//door_collider();
//the_door();
//the_posts();
//the_handle_colliders();