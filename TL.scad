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

tl_fixture_tl_l=1.22/2;
tl_fixture_tl_w=0.0254;
tl_fixture_w=0.112;
tl_fixture_w=0.054;


cyl(d=tl_fixture_tl_w, l=tl_fixture_tl_l, chamfer=tl_fixture_tl_w/10);


//$fn=12; // for buttons
$fn=30;

ddj_width=48.2;
ddj_length=26.7;
ddj_height=3.2;
ddj_jog_wheel_inset_outer=14.2;
ddj_jog_wheel_inset_inner=13.4;
ddj_jog_wheel_inset_drop=0.4;
ddj_jog_wheel_outer=13.3;
ddj_jog_wheel_inner=11.8;
ddj_jog_wheel_h=1.5;

ddj_performance_pad=1.7;
ddj_performance_pad_height=0.2;
ddj_pad_inner=ddj_performance_pad-0.1;
ddj_pad_offset_y=2.2;
ddj_pad_offset_x=2.2;

ddj_function_key=0.4;
ddj_function_key_inner=ddj_function_key-0.1;

ddj_qpp_botan_height=ddj_performance_pad_height;
ddj_qpp_botan=2.2;
ddj_qpp_botan_inset=0.1;
ddj_qpp_botan_inset_ang=30;

ddj_loop_btn=1.4;
ddj_loop_btn_height=0.2;
ddj_loop_btn_inset=0.3;
ddj_loop_btn_inset_ang=15;

ddj_knob_height=1.6;
ddj_knob_base_width=1.5;
ddj_knob_base2_width=1.2;
ddj_knob_top_width=1.0;
ddj_knob_offset1_y=2.45;
ddj_knoblet_height=1.2;
ddj_knoblet_base_width=1.3;
ddj_knoblet_base2_width=1.0;
ddj_knoblet_top_width=0.8;
ddj_knob_pos_indicator_width=0.1;
ddj_knoblet_pos_indicator_width=0.08;

dj_table_depth=50;
dj_table_height=80;
dj_table_width=160;
dj_table_wall=ddj_height*2;
dj_table_rounding=10;
dj_table_led_width=seam_width*100;
dj_table_led_depth=seam_depth*100;
dj_table_led_offset=dj_table_wall-dj_table_led_width;
echo("dj_table_led_offset",dj_table_led_offset);
dj_table_inset_add=1.6;
dj_table_ddj_offset=dj_table_width/3*2-dj_table_width/2; // center on 2/3
echo("dj_table_ddj_offset",dj_table_ddj_offset);

module before_flip_inset() {
    translate([1.3,4.6,0])
    translate([ddj_jog_wheel_inset_outer/2,ddj_jog_wheel_inset_outer/2,-ddj_jog_wheel_inset_drop-mesh_fix]) // 0
    cylinder(h=ddj_jog_wheel_inset_drop+mesh_fix, d1=ddj_jog_wheel_inset_inner, d2=ddj_jog_wheel_inset_outer);
}

module ddj_knob(){
    translate([ddj_knob_base_width/2,ddj_knob_base_width/2,0]) // 0
        union() {
            cylinder(h=0.1, d1=ddj_knob_base_width, d2=ddj_knob_base_width,$fn=12);
            translate([0,0,0.1]) cylinder(h=0.1, d1=ddj_knob_base_width, d2=ddj_knob_base2_width,$fn=12);
            translate([0,0,0.2]) cylinder(h=ddj_knob_height-0.1*2, d1=ddj_knob_base2_width, d2=ddj_knob_top_width,$fn=12);
            ddj_knob_pos_indicator();
        }
}

module ddj_knob_pos_indicator(){
    difference() {
        translate([0,0,0.175]) cylinder(h=ddj_knob_height-0.1*2+ddj_knob_pos_indicator_width/2
        ,d1=ddj_knob_base2_width+ddj_knob_pos_indicator_width/2
        ,d2=ddj_knob_top_width+ddj_knob_pos_indicator_width/2);
        translate([-ddj_knob_base_width/2,ddj_knob_pos_indicator_width/2,0])
        cube([ddj_knob_base_width,ddj_knob_base_width,ddj_knob_height*2]);
        translate([ddj_knob_pos_indicator_width/2,-ddj_knob_base_width/2,0])
        cube([ddj_knob_base_width,ddj_knob_base_width,ddj_knob_height*2]);
        translate([-ddj_knob_base_width-ddj_knob_pos_indicator_width/2,-ddj_knob_base_width/2,0])
        cube([ddj_knob_base_width,ddj_knob_base_width,ddj_knob_height*2]);
    }
}

module ddj_knobletlet_pos_indicator(){
    difference() {
        translate([0,0,0.18]) cylinder(h=ddj_knoblet_height-0.1*2+ddj_knoblet_pos_indicator_width/2
        ,d1=ddj_knoblet_base2_width+ddj_knoblet_pos_indicator_width/2
        ,d2=ddj_knoblet_top_width+ddj_knoblet_pos_indicator_width/2);
        translate([-ddj_knoblet_base_width/2,ddj_knoblet_pos_indicator_width/2,0])
        cube([ddj_knoblet_base_width,ddj_knoblet_base_width,ddj_knoblet_height*2]);
        translate([ddj_knoblet_pos_indicator_width/2,-ddj_knoblet_base_width/2,0])
        cube([ddj_knoblet_base_width,ddj_knoblet_base_width,ddj_knoblet_height*2]);
        translate([-ddj_knoblet_base_width-ddj_knoblet_pos_indicator_width/2,-ddj_knoblet_base_width/2,0])
        cube([ddj_knoblet_base_width,ddj_knoblet_base_width,ddj_knoblet_height*2]);
    }
}

module ddj_knoblet(){
    translate([ddj_knob_base_width/2,ddj_knoblet_base_width/2,0]) // 0
        union() {
            cylinder(h=0.1, d1=ddj_knoblet_base_width, d2=ddj_knoblet_base_width,$fn=12);
            translate([0,0,0.1]) cylinder(h=0.1, d1=ddj_knoblet_base_width, d2=ddj_knoblet_base2_width,$fn=12);
            translate([0,0,0.2]) cylinder(h=ddj_knoblet_height-0.1*2, d1=ddj_knoblet_base2_width,d2=ddj_knoblet_top_width,$fn=12);
            ddj_knobletlet_pos_indicator();
        }
}

module ddj_cue_play_pause() {
    translate([ddj_qpp_botan/2,ddj_qpp_botan/2,0]) 
        cyl(l=ddj_qpp_botan_height, d=ddj_qpp_botan, chamfer2=ddj_qpp_botan_inset, chamfang2=ddj_qpp_botan_inset_ang, orient=UP, center=false);
}

module before_flip_jog_wheel() {
    // jog wheel in two parts
    translate([1.3,4.6,0])
    translate([ddj_jog_wheel_inset_outer/2,ddj_jog_wheel_inset_outer/2,0]) // 0
    // DEBUG ONLY
    //rotate([0,0,360/30/2])
    cylinder(h=ddj_jog_wheel_h, d1=ddj_jog_wheel_outer, d2=ddj_jog_wheel_inner);
    translate([1.3,4.6,0])
    translate([ddj_jog_wheel_inset_outer/2,ddj_jog_wheel_inset_outer/2,-ddj_jog_wheel_inset_drop]) // 0
    // DEBUG ONLY
    //rotate([0,0,360/30/2])
    cylinder(h=ddj_jog_wheel_inset_drop, d1=ddj_jog_wheel_outer, d2=ddj_jog_wheel_outer);
}

module before_flip_adds() {
    before_flip_adds_function_buttons();
    
    // 8 perfomance pads
    translate([4.2,21.2,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2,21.2,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x,21.2,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x,21.2,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x*2,21.2,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*2,21.2,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x*2,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*2,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x*3,21.2,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*3,21.2,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([4.2+ddj_pad_offset_x*3,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_performance_pad,ddj_performance_pad,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*3,21.2+ddj_pad_offset_y,0])
    cuboid([ddj_pad_inner,ddj_pad_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);

    translate([21.6,6.5,0.1])
        ddj_knob();
    translate([21.6,6.5+ddj_knob_offset1_y,0.1])
        ddj_knob();
    translate([17.8,6.5+ddj_knob_offset1_y*5,0.1])
        ddj_knob();
    translate([21.6,6.5+ddj_knob_offset1_y*2,0.1])
        ddj_knob();

    // vol
    translate([21.6,8.5+ddj_knob_offset1_y*4,0.1])
        translate([ddj_knob_base_width/2,0.5,0]) 
        sliding_potentiometer();

    translate([21.6,3.8,0.1])
        ddj_knoblet();
}

module no_flip_adds() {
    translate([ddj_width/2,2.2/2+23.8,0.1]) rotate([0,0,90]) sliding_potentiometer();
    
    translate([ddj_width/2,2.2/2+23.8,0.1]) rotate([0,0,90]) sliding_potentiometer();

    translate([17.8,6.5+ddj_knob_offset1_y,0.1])
        ddj_knob();    
    translate([17.8,6.5+ddj_knob_offset1_y*4,0.1])
        ddj_knob();   
    translate([21.6,6.5+ddj_knob_offset1_y*3,0.1])
        ddj_knob();
 
    // THIS IS ACCURATE FOR X   
    translate([28.9,3.8,0.1])
        ddj_knob();
    
    translate([1.2,19.9,0]) ddj_cue_play_pause();
    translate([1.2,22.7,0]) ddj_cue_play_pause();

    translate([32.7,19.9,0]) ddj_cue_play_pause();
    translate([32.7,22.7,0]) ddj_cue_play_pause();

    translate([1.2+ddj_qpp_botan/2,1.8,0]) ddj_loop_btn();
    translate([1.2+ddj_qpp_botan/2+ddj_loop_btn*1.8,1.8,0]) ddj_loop_btn();

    translate([32.7+ddj_qpp_botan/2,1.8,0]) ddj_loop_btn();
    translate([32.7+ddj_qpp_botan/2+ddj_loop_btn*1.8,1.8,0]) ddj_loop_btn();
    
    translate([13.6+0.8,21.6,0]) sliding_potentiometer_two();
    translate([13.6+0.8+31.5,21.6,0]) sliding_potentiometer_two();
}

module the_deck_base() {
    cuboid([ddj_width,ddj_length,ddj_height], rounding=1, except=[TOP, BOTTOM], p1=[0,0,-ddj_height]);
}

module before_flip_base(){
    difference() {
        // the actual deck
        the_deck_base(); 
        before_flip_inset();
    }
}

module build_deck_jog_wheel() {
    translate([ddj_width,0,0]) mirror([1,0,0]) before_flip_jog_wheel();
    before_flip_jog_wheel();
}

module build_deck_buttons() {
    translate([ddj_width,0,0]) mirror([1,0,0]) before_flip_adds(); 
    before_flip_adds();
    
    // cue, play/pause buttons
    translate([ddj_width,0,0]) mirror([1,0,0]) no_flip_adds();
}

module build_deck() {

}

module build_deck_base() {
    difference() {
        translate([ddj_width,0,0]) mirror([1,0,0]) before_flip_base();
        before_flip_inset();
    }
}

// table dirty+quick
module build_dj_table() {
    difference() {
        // main structure
        rotate([0,90,0]) rect_tube(size=[dj_table_height*2,dj_table_width], wall=dj_table_wall, rounding=dj_table_rounding, h=dj_table_depth);
        // led
        translate([dj_table_depth-dj_table_led_depth,0,0]) rotate([0,90,0]) rect_tube(size=[dj_table_height*2-dj_table_led_offset,dj_table_width-dj_table_led_offset], wall=dj_table_led_width, rounding=dj_table_rounding-dj_table_led_offset/2, h=dj_table_led_depth);
            
        // nb: cut-out has z-fix added to height
        translate([0,-dj_table_ddj_offset,dj_table_height-ddj_height/2+mesh_fix]) rotate([0,0,90]) cuboid([ddj_width+dj_table_inset_add,(ddj_length+dj_table_inset_add)*2,ddj_height+mesh_fix], rounding=1+dj_table_inset_add/2, except=[TOP, BOTTOM]);

        // whack!
        translate([0,0,-100]) cube(200, center=true);
    }
}

module sliding_potentiometer() {
    difference() {
        diff() prismoid(size1=[2.2,1],size2=[2,0.7], h=1.4
            ,rounding=0.05,$fn=12) {
            edge_profile([TOP], excess=0.1) {
                mask2d_roundover(h=0.05,mask_angle=$edge_angle);
            }
        };
        cube([3,ddj_knob_pos_indicator_width,4],center=true);
    }
    
    diff() prismoid(size1=[2.2-ddj_knob_pos_indicator_width/2,1-ddj_knob_pos_indicator_width]
        ,size2=[2-ddj_knob_pos_indicator_width/2,0.7-ddj_knob_pos_indicator_width]
        ,h=1.4-ddj_knob_pos_indicator_width/4,$fn=12) {
        edge_profile([TOP],excess=0.1) {
            mask2d_roundover(h=0.05-ddj_knob_pos_indicator_width/4,mask_angle=$edge_angle);
        }
    };
}

module sliding_potentiometer_two_meta() {
    difference() {
        diff() translate([0,0,0.55-mesh_fix]) cuboid([1.6,0.5,0.9+mesh_fix]) 
            edge_profile([TOP],excess=0.1,$fn=12) {
                mask2d_roundover(h=0.05,mask_angle=$edge_angle);
            };
        translate([0,0,0.9+1.1-0.475]) cuboid([2,0.05,1.1]);
    }
    
    cuboid([1.6,1.9,0.2],rounding=0.2,except=[TOP,BOTTOM],$fn=12);

    difference() {
        mirror([0,1,0]) translate([0,0.25,0.1]) zrot(90) xrot(90)
            linear_extrude(height=1.6,center=true)
                mask2d_roundover(r=0.5,$fn=15);
    }
    
    difference() {
        translate([0,0.25,0.1]) zrot(90) xrot(90)
            linear_extrude(height=1.6,center=true)
                mask2d_roundover(r=0.5,$fn=15);
    }
}

module sliding_potentiometer_two() {
    translate([0,0,0.1]) sliding_potentiometer_two_meta();
}

module before_flip_adds_function_buttons() {
    // 4 function buttons
    translate([4.2,19.8,0])
    cuboid([ddj_performance_pad,ddj_function_key,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2,19.8,0])
    cuboid([ddj_pad_inner,ddj_function_key_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);
    
    translate([4.2+ddj_pad_offset_x,19.8,0])
    cuboid([ddj_performance_pad,ddj_function_key,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x,19.8,0])
    cuboid([ddj_pad_inner,ddj_function_key_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);
    
    translate([4.2+ddj_pad_offset_x*2,19.8,0])
    cuboid([ddj_performance_pad,ddj_function_key,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*2,19.8,0])
    cuboid([ddj_pad_inner,ddj_function_key_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);
    
    translate([4.2+ddj_pad_offset_x*3,19.8,0])
    cuboid([ddj_performance_pad,ddj_function_key,ddj_performance_pad_height], chamfer=0.02, except=[BOTTOM, TOP], p1=[0,0,0]);
    translate([4.2+ddj_pad_offset_x*3,19.8,0])
    cuboid([ddj_pad_inner,ddj_function_key_inner,ddj_performance_pad_height], p1=[(ddj_performance_pad-ddj_pad_inner)/2,(ddj_performance_pad-ddj_pad_inner)/2,0]);
    
}

module ddj_loop_btn() {
    translate([0,ddj_loop_btn/2,0]) 
        cyl(l=ddj_loop_btn_height
            ,d=ddj_loop_btn
            ,chamfer2=ddj_loop_btn_inset
            ,chamfang2=ddj_loop_btn_inset_ang
            ,orient=UP
            ,center=false
            ,$fn=15);
}

module dj_stuff() {
    scale(0.01) dj_stuff_prescale();
}

module dj_stuff_prescale() {
    build_dj_table();
    translate([dj_table_inset_add/2,0,0]) // nudge inward
        translate([ddj_length,-ddj_width/2-dj_table_ddj_offset,dj_table_height]) rotate([0,0,90]) 
            build_deck_base();
    
    translate([dj_table_inset_add/2,0,0]) // nudge inward
        translate([ddj_length,-ddj_width/2-dj_table_ddj_offset,dj_table_height]) rotate([0,0,90]) 
            build_deck_buttons();
    
    translate([dj_table_inset_add/2,0,0]) // nudge inward
        translate([ddj_length,-ddj_width/2-dj_table_ddj_offset,dj_table_height]) rotate([0,0,90]) 
            build_deck_jog_wheel();
}

//translate([-wall_size_inner/8*5,wall_size_inner/4,wall_thickness*4])
//    dj_stuff();
