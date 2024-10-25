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

wall_sconce1_height=0.300;
wall_sconce1_ext=0.110;
wall_sconce1_width=0.180;
wall_sconce1_inset=0.005;

module wall_sconce1() {
    rotate([90,0,0])
        difference() {
            prismoid(size1=[wall_sconce1_width,wall_sconce1_height],size2=[0,wall_sconce1_height/3],h=wall_sconce1_ext);
            translate([0,0,wall_sconce1_inset])
                scale([0.90,1.5,0.90])
                    prismoid(size1=[wall_sconce1_width,wall_sconce1_height],size2=[0,wall_sconce1_height/3],h=wall_sconce1_ext);
        }

        rotate([90,0,0])
            prismoid(size1=[wall_sconce1_width
                ,wall_sconce1_height/6]
                ,size2=[0,wall_sconce1_height/6]
                ,h=wall_sconce1_ext);
}

module apt_no(apt_no) {
    translate ([0,-wall_sconce1_inset,-0.3])
        rotate([90,0,0]) 
            linear_extrude(wall_sconce1_inset)
                scale(0.01)
                    text(apt_no,font="Orbitron",valign="top",halign="center");
}

//wall_sconce1();
//apt_no("103");