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

offset_modifier = wall_size_inner/8;
//offset_modifier = phi;
slab_count = 9;
slab_upright_width = 1;

module firma4() {
    // bottom
    // upright slabs
    for ( i = [1 : 1 : slab_count] ){
        if ((i > 8) || (i < 4) || (i == 6)) {
            height = 1 + i * 0.3;
            offset = (i - 5) * offset_modifier - wall_thickness/8;
            translate([offset, -seam_depth/2, 0])
            cuboid(
                [slab_upright_width - wall_thickness/4, wall_thickness, height], chamfer=seam_width,
                except=[BOTTOM, RIGHT],
                anchor=BOTTOM
            );
        }
    }

    for ( i = [1 : 1 : slab_count] ){
        if ((i > 8) || (i < 4) || (i == 6)) {
            height = 1 + i * 0.3;
            offset = (i - 5) * offset_modifier + wall_thickness/8;
            translate([offset, seam_depth/2, 0])
            cuboid(
                [slab_upright_width - wall_thickness/4, wall_thickness, height], chamfer=seam_width,
                except=[BOTTOM, LEFT],
                anchor=BOTTOM
            ); 
        }
    }

    // top
    // upright slabs
    for ( i = [1 : 1 : slab_count] ){
        height = 1 + i * 0.3;
        offset = (i - 5) * offset_modifier - wall_thickness/8;
        translate([-offset, -seam_depth/2, 3.2 + 7 * 0.3])
        cuboid(
            [slab_upright_width - wall_thickness/4, wall_thickness, height], chamfer=seam_width,
            except=[LEFT],
            anchor=TOP
        );
    }

    for ( i = [1 : 1 : slab_count] ){
        height = 1 + i * 0.3;
        offset = (i - 5) * offset_modifier + wall_thickness/8;
        translate([-offset, seam_depth/2, 3.2 + 7 * 0.3])
        cuboid(
            [slab_upright_width - wall_thickness/4, wall_thickness, height], chamfer=seam_width,
            except=[RIGHT],
            anchor=TOP
        ); 
    }
}

//firma4();
