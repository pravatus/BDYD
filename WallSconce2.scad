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

wall_sconce2_base=0.08;
wall_sconce2_base_inset=0.005;
wall_sconce2_ornament_d=0.005;
wall_sconce2_plate_xtra=0.02;
wall_sconce2_lamp_mod=3;

wall_sconce2_lamp_width=wall_sconce2_base-wall_sconce2_base_inset*2;
echo("wall_sconce2_lamp_width",wall_sconce2_lamp_width);
wall_sconce2_lamp_height=wall_sconce2_lamp_width*wall_sconce2_lamp_mod;
echo("wall_sconce2_lamp_height",wall_sconce2_lamp_height);
wall_sconce2_ornament_height=wall_sconce2_base*3;
echo("wall_sconce2_ornament_height",wall_sconce2_ornament_height);
wall_sconce2_plate_height=wall_sconce2_plate_xtra*2+wall_sconce2_base+wall_sconce2_lamp_height*2;
echo("wall_sconce2_plate_height",wall_sconce2_plate_height);
wall_sconce2_plate_width=wall_sconce2_plate_xtra*2+wall_sconce2_lamp_width;
echo("wall_sconce2_plate_width",wall_sconce2_plate_width);

module wall_sconce2() {
    // plate
    cuboid([wall_sconce2_plate_width,wall_sconce2_plate_height,wall_sconce2_base_inset+mesh_fix],
        p1=[-wall_sconce2_plate_width/2,-wall_sconce2_plate_height/2,-mesh_fix]);
    // main cube
    cuboid([wall_sconce2_base,wall_sconce2_base,wall_sconce2_base-wall_sconce2_base_inset],
        p1=[-wall_sconce2_base/2,-wall_sconce2_base/2,wall_sconce2_base_inset]);
    // lamp 1
    cuboid([wall_sconce2_lamp_width,wall_sconce2_lamp_height,wall_sconce2_lamp_width],
        p1=[-wall_sconce2_lamp_width/2,-wall_sconce2_lamp_height-wall_sconce2_base/2,wall_sconce2_base_inset]);
    // lamp 2
    cuboid([wall_sconce2_lamp_width,wall_sconce2_lamp_height,wall_sconce2_lamp_width],
        p1=[-wall_sconce2_lamp_width/2,wall_sconce2_base/2,wall_sconce2_base_inset]);
    // ornament
    cuboid([wall_sconce2_ornament_d,wall_sconce2_ornament_height,wall_sconce2_ornament_d],p1=[-wall_sconce2_ornament_d/2,-wall_sconce2_ornament_height/2,wall_sconce2_base]);
}

//wall_sconce2();