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

$fn=8; // low poly truss

truss_alignment_rot_deg=360/$fn/2; // $fn=8, 4
//truss_alignment_rot_deg=360/$fn; // $fn=6

truss_scale=0.01;
truss_chord_spacing=30;
truss_diagonal_members_spacing=7;
truss_diagonal_ladder_length=sqrt(truss_chord_spacing^2+truss_chord_spacing^2);
echo("truss_diagonal_ladder_length",truss_diagonal_ladder_length);
truss_diagonal_members_z_spacing=truss_chord_spacing*3+truss_diagonal_members_spacing*5;
echo("truss_diagonal_members_z_spacing",truss_diagonal_members_z_spacing);
truss_chord_diameter=3;
truss_height=truss_diagonal_members_z_spacing*1.5;
truss_final_height=truss_height+truss_diagonal_members_spacing;
echo("truss_final_height",truss_final_height);
truss_member_diagonal_diameter_max=truss_chord_diameter/(1+sqrt(2));
echo("truss_member_diagonal_diameter_max",truss_member_diagonal_diameter_max);
truss_member_diagonal_diameter=1;
truss_cable_long_bit=30;
truss_cable_diameter=0.4;
truss_cable_loop_diag_deg=30;

module truss_part() {
    // chords
    translate([0,0,-truss_final_height/2]) // set to zero
        ycopies(l=truss_chord_spacing, n=2) xcopies(l=truss_chord_spacing, n=2) 
            rotate([0,0,truss_alignment_rot_deg]) // align for 8
                cylinder(h=truss_final_height, r=truss_chord_diameter);

    // horizontal members
    translate([truss_chord_spacing/2,truss_chord_spacing/2,0]) // set to 0
        zcopies(l=truss_height, n=4) rotate([90,0,0]) 
            rotate([0,0,truss_alignment_rot_deg]) // align for 8
                cylinder(h=truss_chord_spacing, r=truss_member_diagonal_diameter);

    translate([-truss_chord_spacing/2,truss_chord_spacing/2,0]) // set to 0
        zcopies(l=truss_height, n=4) rotate([90,0,0]) 
            rotate([0,0,truss_alignment_rot_deg]) // align for 8
                cylinder(h=truss_chord_spacing, r=truss_member_diagonal_diameter);
        
    // horizontal members
    translate([-truss_chord_spacing/2,truss_chord_spacing/2,0]) // set to 0
        zcopies(l=truss_height, n=4) rotate([0,90,0]) 
            rotate([0,0,truss_alignment_rot_deg]) // align for 8
                cylinder(h=truss_chord_spacing, r=truss_member_diagonal_diameter);

    translate([-truss_chord_spacing/2,-truss_chord_spacing/2,0]) // set to 0
        zcopies(l=truss_height, n=7) rotate([0,90,0]) 
            rotate([0,0,truss_alignment_rot_deg]) // align for 8
                cylinder(h=truss_chord_spacing, r=truss_member_diagonal_diameter);

    // ladder 1
    translate([0,truss_chord_spacing/2,-truss_chord_spacing]) // set to 0 
        translate([0,0,-0.5]) // offset
            xcopies(l=truss_chord_spacing, n=2) zcopies(l=truss_diagonal_members_z_spacing, n=3)
                rotate([45,0,0]) 
                    rotate([0,0,truss_alignment_rot_deg]) // align for 8
                        cylinder(h=truss_diagonal_ladder_length, r=truss_member_diagonal_diameter);

    // ladder 2
    translate([0,-truss_chord_spacing/2,0]) // set to 0
        translate([0,0,0.5]) // offset
            xcopies(l=truss_chord_spacing, n=2) zcopies(l=truss_diagonal_members_z_spacing, n=3)
                rotate([-45,0,0]) 
                    rotate([0,0,truss_alignment_rot_deg]) // align for 8
                        cylinder(h=truss_diagonal_ladder_length, r=truss_member_diagonal_diameter);
}

module bolt_plates() {
    // bolt plate
    ycopies(l=truss_chord_spacing, n=2) 
        hull() { 
            xcopies(l=truss_chord_spacing, n=2) 
                rotate([0,0,truss_alignment_rot_deg]) // align for 8
                    cylinder(h=truss_member_diagonal_diameter, r=truss_chord_diameter);
        }

    //translate([0,0,-truss_final_height/2]) // ze top
    xcopies(l=truss_chord_spacing, n=2) 
        hull() { 
            ycopies(l=truss_chord_spacing, n=2) 
                rotate([0,0,truss_alignment_rot_deg]) // align for 8
                    cylinder(h=truss_member_diagonal_diameter, r=truss_chord_diameter);
        }

    // bolt plate
    translate([0,0,truss_final_height-truss_member_diagonal_diameter]) // ze top
        ycopies(l=truss_chord_spacing, n=2) 
            hull() { 
                xcopies(l=truss_chord_spacing, n=2) 
                    rotate([0,0,truss_alignment_rot_deg]) // align for 8
                        cylinder(h=truss_member_diagonal_diameter, r=truss_chord_diameter);
            }

    translate([0,0,truss_final_height-truss_member_diagonal_diameter]) // ze top
        xcopies(l=truss_chord_spacing, n=2) 
            hull() { 
                ycopies(l=truss_chord_spacing, n=2) 
                    rotate([0,0,truss_alignment_rot_deg]) // align for 8
                        cylinder(h=truss_member_diagonal_diameter, r=truss_chord_diameter);
            }
}

module truss_segment() {
    translate([0,0,truss_final_height/2]) truss_part();
    bolt_plates();
}

module cable_loop() {
    truss_cable_loop_diameter=truss_chord_diameter+truss_cable_diameter+0.2;
    cable_loop_leg=5.26;
    path = turtle3d([
        "move",truss_cable_long_bit, 
        "arcdown",truss_cable_loop_diameter
            ,truss_cable_loop_diag_deg,
            "move",cable_loop_leg,
        "arcup",truss_cable_loop_diameter,180+2*truss_cable_loop_diag_deg,
            "move",cable_loop_leg,
        //"arcdown",truss_cable_loop_diameter
        //    ,truss_cable_loop_diag_deg,
        //"move",2
        ]
        ,transforms=true);

    sweep(circle(truss_cable_diameter),path);
}
//rotate([90,360/16,0]) cylinder(h=1,r=truss_chord_diameter); 
//translate([-truss_cable_long_bit-8.1,0,0]) cable_loop();

module rigging() {
    translate([-truss_chord_spacing/2,0,-truss_chord_spacing-truss_chord_diameter])
        rotate([0,-90,0])
            mirror([0,0,1])
                translate([-truss_cable_long_bit-8.1,0,0]) cable_loop();

    translate([truss_chord_spacing/2,0,-truss_chord_spacing-truss_chord_diameter])
        rotate([0,-90,0])
           translate([-truss_cable_long_bit-8.1,0,0]) cable_loop();
}

module four_trusses() {
    rotate([-90,0,0]) truss_segment();
    translate([0,truss_final_height,0]) rotate([-90,0,0]) truss_segment();
    translate([0,truss_final_height*2,0]) rotate([-90,0,0]) truss_segment();
    translate([0,truss_final_height*3,0]) rotate([-90,0,0]) truss_segment();
}
//four_trusses();

//scale(truss_scale) translate([0,-truss_final_height*2,-truss_chord_spacing/2-truss_chord_diameter]) four_trusses();
//scale(truss_scale) translate([0,-truss_final_height/2,-truss_chord_spacing/2-truss_chord_diameter]) rotate([-90,0,0]) truss_segment();
//scale(truss_scale) rigging();
