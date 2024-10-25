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
speak_depth=3.4;
speak_height=5.7;
speak_width=3.5;
speak_ratio=0.8;
speak_back_width=speak_width*speak_ratio;
echo ("speak_back_width",speak_back_width);
speak_top_box_height=(speak_height-woof_box*3)/12*4;
echo ("speak_top_box_height",speak_top_box_height);
speak_bottom_box_hight=(speak_height-woof_box*3)/12*8;
echo ("speak_bottom_box_hight",speak_bottom_box_hight);
speak_box_width=speak_width-2*woof_box;
echo ("speak_box_width",speak_box_width);
speak_box_back_width=speak_back_width-2*woof_box;
echo ("speak_box_back_width",speak_box_back_width);
speak_bottom_box_z=1*woof_box;
echo ("speak_bottom_box_z",speak_bottom_box_z);
speak_top_box_hole_height=speak_top_box_height/12*5;
echo ("speak_top_box_hole_height",speak_top_box_hole_height);
speak_top_box_z=2*woof_box+speak_bottom_box_hight;
echo ("speak_top_box_z",speak_top_box_z);
suggest_speak_top_box_hole_depth=woof_top_box_hole_depth*speak_depth/woof_depth;
echo ("suggest_speak_top_box_hole_depth",suggest_speak_top_box_hole_depth);
speak_top_box_hole_depth=2.2;

module speak_base_geom() { // 4 x 4 overlapping verts
    diff() prismoid([speak_height,speak_width],[speak_height,speak_back_width]
        ,h=speak_depth) {
        edge_profile([TOP+FRONT,TOP+BACK],excess=0.1) {
            mask2d_roundover(h=woof_back_rounding,mask_angle=$edge_angle);
        }
        edge_profile([BOTTOM+FRONT,BOTTOM+BACK],excess=0.1) {
            mask2d_roundover(h=woof_front_rounding,mask_angle=$edge_angle);
        }
    }
}

module speak() {
    difference() {
        translate([speak_depth/2,0,speak_height/2])
            rotate([0,-90,0])
                speak_base_geom();
        speak_cutouts();
    }
}

module speak_cutouts() {
    // bottom box
    translate([0,0,speak_bottom_box_z])
        translate([0,0,speak_bottom_box_hight/2]) // 0
            translate([speak_depth,0,0])
                cuboid([speak_depth,speak_box_width,speak_bottom_box_hight]);
    translate([0,0,speak_bottom_box_z])
        difference() {
            translate([speak_depth/2,0,speak_bottom_box_hight/2]) rotate([0,-90,0]) // 0
                prismoid([speak_bottom_box_hight,speak_box_width],[speak_bottom_box_hight,speak_box_back_width]
                    ,h=speak_depth);
            translate([0,0,speak_bottom_box_hight/2]) // 0
                translate([-woof_seam_depth,0,0])
                    cuboid([speak_depth,speak_box_width,speak_bottom_box_hight]);
        }

    // speaker cone
    speak_cone_width=speak_box_width/8*6;
    speak_cone_depth=speak_cone_width/8;
    translate([0,0,0]) // 0
        translate([speak_depth/2-woof_seam_depth-speak_cone_depth/2
        ,0
        ,speak_bottom_box_z+speak_bottom_box_hight/2])
            xcyl(l=speak_cone_depth,
                d1=speak_cone_width/3,
                d2=speak_cone_width);

    speak_top_box_cutout();

    woof_handle();
}
//speak_cutouts();

module speak_top_box_bottom_shape() {
    translate([0,0,speak_top_box_z])
        translate([0,0,speak_top_box_height/12*5/2]) // 0
            difference() {
                translate([speak_depth/2,0,0])
                    rotate([0,-90,0])
                        diff()
                            prismoid([speak_top_box_height/12*5, speak_width-2*woof_box]
                                ,[speak_top_box_height/12*5,speak_width-2*woof_box], h=speak_depth)
                                edge_profile([BOTTOM+RIGHT])
                                    mask2d_roundover(r=speak_top_box_height/12*5, mask_angle=90, inset=[0,woof_seam_depth]);
                translate([speak_depth/2+5-woof_seam_depth,0,0]) cube(10, center=true);
                translate([speak_depth/2-5-woof_seam_depth-speak_top_box_hole_depth,0,0]) cube(10, center=true);
            }
}

module speak_top_box_top_shape() {
    translate([0,0,speak_top_box_z])
        translate([0,0,speak_top_box_height/12*5/2+speak_top_box_height/12*7]) // 0
            difference() {
                translate([speak_depth/2,0,0])
                    rotate([0,-90,0])
                        diff()
                            prismoid([speak_top_box_height/12*5,speak_width-2*woof_box]
                            ,[speak_top_box_height/12*5, speak_width-2*woof_box], h=speak_depth)
                                edge_profile([BOTTOM+LEFT])
                                    mask2d_roundover(r=speak_top_box_height/12*5,mask_angle=90,inset=[0,woof_seam_depth]);
                translate([speak_depth/2+5-woof_seam_depth,0,0]) cube(10, center=true);
                translate([speak_depth/2-5-woof_seam_depth-speak_top_box_hole_depth,0,0]) cube(10, center=true);
            }
}

module speak_top_box_cutout_base_geom() {
    // top box
    translate([0,0,speak_top_box_z])
        translate([0,0,speak_top_box_height/2]) // 0
            translate([speak_depth,0,0])
                cuboid([speak_depth,speak_box_width,speak_top_box_height]);
    translate([0,0,speak_top_box_z])
        difference() {
            translate([speak_depth/2,0,speak_top_box_height/2]) rotate([0,-90,0]) // 0
                prismoid([speak_top_box_height,speak_box_width],[speak_top_box_height,speak_box_back_width]
                    ,h=speak_depth);
            translate([0,0,speak_top_box_height/2]) // 0
                translate([-speak_top_box_hole_depth,0,0])
                    cuboid([speak_depth,speak_box_width,speak_top_box_height]);
        }
}

module speak_top_box_cutout() {
    difference() {
        speak_top_box_cutout_base_geom();
        speak_top_box_top_shape();
        speak_top_box_bottom_shape();
    }
}

module woof_base_geom() {
    prismoid([woof_depth, woof_width],[woof_depth, woof_width]
        ,h=woof_height
        ,rounding=[woof_front_rounding,woof_back_rounding,woof_back_rounding,woof_front_rounding]);
}
//woof_base_geom();

module woof_cutouts() {
    // bottom box
    translate([0,0,woof_bottom_box_hight/2]) // 0
        translate([woof_depth-woof_seam_depth,0,woof_bottom_box_z])
            cuboid([woof_depth,woof_box_width,woof_bottom_box_hight]);

    woof_top_box_cutout();

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

module woof_top_box_cutout() {
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
                        // obtuse angle would fix double verts...
                        mask2d_roundover(r=woof_top_box_hole_height,mask_angle=90);
    }
}

module woof_rig() {
    rect_tube(size=[woof_depth,woof_height], wall=0.1, chamfer=0.2, h=0.6);
    translate([0,0,0.3])
        cuboid([woof_depth-0.2+mesh_fix,0.1,0.6]);
}

module speak_rig() {
    rect_tube(size=[speak_depth,speak_height], wall=0.1, chamfer=0.2, h=0.6);
    translate([0,0,0.3])
        cuboid([speak_depth-0.2+mesh_fix,0.1,0.6]);
}

module rigged_speakers() {
    speak_angle=5.877;

    translate([0,0,-0.6]) speak_rig();

    translate([0,0,-0.65])
        rotate([0,speak_angle,0])
            translate([0,-speak_height/2,-1.575])
                rotate([-90,0,0])
                    speak();
    translate([0,0,-0.65])
        rotate([0,speak_angle*3,0])
            translate([0.64,-speak_height/2,-4.707])
                rotate([-90,0,0])
                    speak();
    translate([0,0,-0.65])
        rotate([0,speak_angle*5,0])
            translate([1.91,-speak_height/2,-7.641])
                rotate([-90,0,0])
                    speak();
}

module rigged_woofers() {
    translate([0,0,-0.6]) woof_rig();
    translate([0,woof_height/2,-woof_width/2-0.65]) rotate([90,0,0]) woof();
    translate([0,woof_height/2,-woof_width*1.5-0.65-0.05]) rotate([90,0,0]) woof();
}

module unrigged_woofers() {
    translate([0,woof_height/2,-woof_width/2-0.65]) rotate([90,0,0]) woof();
    translate([0,woof_height/2,-woof_width*1.5-0.65-0.05]) rotate([90,0,0]) woof();
}

module unrigged_speakers() {
    speak_angle=5.877;

    translate([0,0,-0.65])
        rotate([0,speak_angle,0])
            translate([0,-speak_height/2,-1.575])
                rotate([-90,0,0])
                    speak();
    translate([0,0,-0.65])
        rotate([0,speak_angle*3,0])
            translate([0.64,-speak_height/2,-4.707])
                rotate([-90,0,0])
                    speak();
    translate([0,0,-0.65])
        rotate([0,speak_angle*5,0])
            translate([1.91,-speak_height/2,-7.641])
                rotate([-90,0,0])
                    speak();
}

// deliverables
//scale(woof_scale) rigged_woofers();
//scale(woof_scale) rigged_speakers();

