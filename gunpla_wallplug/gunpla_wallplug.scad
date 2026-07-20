base_thickness = 4;

base_width = 30; // Thickness of the base body
base_height = 40;
base_depth = 30; // Distance the base sticks out

hook_depth = 30;

peg_length = 12; // Length of the 3mm peg
peg_diameter = 2.8; // Tolerance adjusted for 3mm hole
peg_height = 40;
peg_base = 15;

union() {
  translate([0, -3, -base_width / 2])
    cube([base_thickness, base_height, base_width]);

  rotate([90, 0, 0])
    translate([base_thickness, -base_width / 2, 0])
      linear_extrude(3) {
        polygon(
          [
            [0, 0],
            [0, base_width],
            [base_depth, base_width - peg_base],
            [base_depth, 0],
          ]
        );
      }

  translate([base_depth + 1, 0, 0])
    rotate([90, 90, 60])
      linear_extrude(height=3) {
        polygon(
          [
            [0, 0],
            [peg_base, 0],
            [peg_base, peg_height],
            [peg_base - 3, peg_height],
          ]
        );
      }

  // The 3mm Peg at the tip
  // Rotated to point upwards to fit into the bottom of the Gunpla
  translate([
      base_depth + 2 + sin(30)*peg_height,
      peg_height - peg_length + 5,
      -base_width / 2 + 1.5,
    ])
    rotate([-90, 0, 0])
      cylinder(d=peg_diameter, h=peg_length, $fn=50);
}
