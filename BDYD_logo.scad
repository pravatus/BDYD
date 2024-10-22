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

text_extrude=0.005;

module bdyd_logo() {
    scale([1,0.7,1]) 
        rotate([0,0,-30]) 
            linear_extrude(text_extrude) 
                regular_ngon(n=3,or=0.1);

    scale([1,0.7,1]) 
        translate([0,0.05,0]) 
            difference() {
                rotate([0,0,-30]) 
                    linear_extrude(text_extrude) 
                        regular_ngon(n=3,or=0.1);
                rotate([0,0,-30]) 
                    linear_extrude(text_extrude) 
                        regular_ngon(n=3,or=0.1-text_extrude);
            }

    scale([1,0.7,1]) 
            translate([0,0.1,0]) difference() {
                rotate([0,0,-30]) 
                    linear_extrude(text_extrude) 
                        regular_ngon(n=3,or=0.1);
                rotate([0,0,-30]) 
                    linear_extrude(text_extrude) 
                        regular_ngon(n=3,or=0.1-text_extrude);
            }

    translate([0,-0.10,0]) 
        linear_extrude(text_extrude) 
            scale(0.02) 
                text("BDYD?",font="Major Mono Display",valign="top",halign="center",$fn=12);
}

//bdyd_logo();
