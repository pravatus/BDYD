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
