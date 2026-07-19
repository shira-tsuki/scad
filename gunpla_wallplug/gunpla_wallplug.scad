base_thickness = 4;
hook_depth = 45; // Distance the hook sticks out
hook_width = 30; // Thickness of the hook body
hook_height = 40;
peg_length = 20; // Length of the 3mm peg
peg_diameter = 2.8; // Tolerance adjusted for 3mm hole
peg_height = 40;
peg_base = 15;

union() {
  translate([0, 0, -hook_width / 2])
    cube([base_thickness, hook_height, hook_width]);

  rotate([90, 0, 0])
    translate([0, -hook_width / 2, 0])
      linear_extrude(3) {
        polygon(
          [
            [0, 0],
            [0, hook_width],
            [hook_depth, hook_width - (hook_width - peg_base) / 2],
            [hook_depth, (hook_width - peg_base) / 2],
          ]
        );
      }

  translate([hook_depth - 3, 0, peg_base / 2])
    rotate([90, 90, 90])
      linear_extrude(height=3) {
        polygon(
          [
            [0, 0],
            [peg_base, 0],
            [peg_base / 2, peg_height],
          ]
        );
      }

  // The 3mm Peg at the tip
  // Rotated to point upwards to fit into the bottom of the Gunpla
  translate([hook_depth - 1.5, peg_height - peg_length + 10, 0])
    rotate([-90, 0, 0])
      cylinder(d=peg_diameter, h=peg_length, $fn=50);
}
