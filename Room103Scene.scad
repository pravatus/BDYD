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

include <Room103-2.scad>
include <Truss.scad>

translate([-wall_size_outer/5*4,0,corridor_height]) 
scale(0.01) translate([0,-truss_final_height*2.5,-truss_chord_spacing/2-truss_chord_diameter]) five_trusses();

build_room103_collider();