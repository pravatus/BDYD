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

include <Speakers.scad>
include <Truss.scad>

$fn=8; // low poly truss

module Room103_fn8() {
    scale(0.1) translate([0,-truss_final_height*2,-truss_chord_spacing/2-truss_chord_diameter]) four_trusses();

    ycopies(l=truss_final_height/10*4-truss_chord_spacing*3/10, n=2) 
        scale(0.1) rigging();
    ycopies(l=truss_final_height/10*3-truss_chord_spacing*3/10, n=2) 
        scale(0.1) rigging();

    translate([0,(truss_final_height/10*3-truss_chord_spacing*3/10)/2,-7])
        translate([0,0,-0.6])
            woof_rig();

    translate([0,-(truss_final_height/10*3-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0])
            translate([0,0,-0.6]) 
                woof_rig();

    translate([0,-(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        translate([0,0,-0.6]) 
            speak_rig();

    translate([0,(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0]) 
            translate([0,0,-0.6]) 
                speak_rig();
}

module _Room103_fn8() {
    scale(0.1) translate([0,-truss_final_height*2.5,-truss_chord_spacing/2-truss_chord_diameter]) five_trusses();

    ycopies(l=truss_final_height/10*5-truss_chord_spacing*3/10, n=2) 
        scale(0.1) rigging();
    ycopies(l=truss_final_height/10*4-truss_chord_spacing*3/10, n=2) 
        scale(0.1) rigging();

    translate([0,(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        translate([0,0,-0.6])
            woof_rig();

    translate([0,-(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0])
            translate([0,0,-0.6]) 
                woof_rig();

    translate([0,-(truss_final_height/10*5-truss_chord_spacing*3/10)/2,-7])
        translate([0,0,-0.6]) 
            speak_rig();

    translate([0,(truss_final_height/10*5-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0]) 
            translate([0,0,-0.6]) 
                speak_rig();
}

translate([-wall_size_outer/5*4,0,corridor_height]) scale(woof_scale) _Room103_fn8();