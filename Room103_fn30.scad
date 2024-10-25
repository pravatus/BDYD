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

$fn=30; // low poly truss

module Room103_fn30() {
    translate([0,(truss_final_height/10*3-truss_chord_spacing*3/10)/2,-7])
        unrigged_woofers();

    translate([0,-(truss_final_height/10*3-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0]) 
            unrigged_woofers();

    translate([0,-(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        unrigged_speakers();

    translate([0,(truss_final_height/10*4-truss_chord_spacing*3/10)/2,-7])
        mirror([0,1,0]) 
            unrigged_speakers();
}

//scale(woof_scale) Room103_fn30();