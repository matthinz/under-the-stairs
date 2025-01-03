include <utils.scad>;

LITTER_BOX_WIDTH = 14 * INCHES;
LITTER_BOX_HEIGHT = 17 * INCHES;
LITTER_BOX_DEPTH = 20 * INCHES;
LITTER_BOX_WALL_THICKNESS = (1/4) * INCHES;

module litter_box(litter_box_color = "white") {

  color(litter_box_color) {
  difference() {
    cube([LITTER_BOX_WIDTH, LITTER_BOX_DEPTH, LITTER_BOX_HEIGHT], center=true);
    cube(
      [
        LITTER_BOX_WIDTH - 2 * LITTER_BOX_WALL_THICKNESS,
        LITTER_BOX_DEPTH - 2 * LITTER_BOX_WALL_THICKNESS,
        LITTER_BOX_HEIGHT - 2 * LITTER_BOX_WALL_THICKNESS,
      ],
      center = true
    );

    translate([0, -LITTER_BOX_WALL_THICKNESS, LITTER_BOX_HEIGHT / 5])
      rotate([90, 0, 0])
      cylinder(
        h = LITTER_BOX_DEPTH,
        r1 = LITTER_BOX_WIDTH / 3,
        r2 = LITTER_BOX_WIDTH / 3,
        center = true
      );
  }
  }
}

