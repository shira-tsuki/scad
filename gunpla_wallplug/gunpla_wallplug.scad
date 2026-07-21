print_buffer = 0.2;

base_thickness = 4;
base_wall_height = 50;
base_wall_width = 30;
base_mount_depth = 60;
base_hole_width = 12;
base_hole_depth = 40;
base_hole_height = 2;

stand_height = 30;
stand_depth = 8;
stand_width = 3;
peg_length = 10;
peg_diameter = 2.8;

stopper_width = 3;
stopper_height = 15;

render_module = "base";

module base() {
  rotate([90, 0, 0])
    translate([-base_mount_depth / 2, -base_wall_width / 2, 0])
      difference() {
        union() {
          rotate([0, -90, 0]) cube([base_wall_height, base_wall_width, base_thickness]);
          cube([base_mount_depth, base_wall_width, base_thickness]);
        }
        translate([base_hole_depth, (base_wall_width - base_hole_width) / 2, base_thickness - base_hole_height]) cube([base_hole_width, base_hole_width, base_hole_height]);
      }
}

module stand() {
  rotate([0, -90, 0])
    union() {
      translate([0, -(base_hole_width - print_buffer) / 2, 0]) cube([base_hole_width - print_buffer, base_hole_width - print_buffer, base_hole_height]);

      translate([peg_diameter / 2, 0, stand_height]) cylinder(d=peg_diameter, h=peg_length, $fn=50);

      translate([0, -stand_width / 2, 0])
        rotate([0, -90, -90])
          linear_extrude(height=stand_width) {
            polygon(
              [
                [0, 0],
                [0, base_hole_width - print_buffer],
                [stand_height, stand_width],
                [stand_height, 0],
              ]
            );
          }
    }
}

module stopper() {
  rotate([0, -90, 0])
    union() {
      translate([0, -(base_hole_width - print_buffer) / 2, 0]) cube([base_hole_width - print_buffer, base_hole_width - print_buffer, base_hole_height]);

      translate([0, -stopper_width / 2, 0])
        cube([stopper_width, stopper_width, stopper_height]);
    }
}

if (render_module == "base") {
  base();
} else if (render_module == "stand") {
  stand();
} else if (render_module == "stopper") {
  stopper();
}

