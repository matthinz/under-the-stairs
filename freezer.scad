include <utils.scad>;

FREEZER_WIDTH = 30 * INCHES;
FREEZER_HEIGHT = (32 + (1/2)) * INCHES;
FREEZER_DEPTH = 22 * INCHES;

FREEZER_WALL_THICKNESS = 1 * INCH;

FREEZER_LID_HEIGHT = (2 + (3/8)) * INCHES;
FREEZER_LID_SEAL_HEIGHT = (1/2) * INCHES;

FREEZER_BODY_HEIGHT = FREEZER_HEIGHT - FREEZER_LID_HEIGHT;

module freezer(freezer_color = "white", open = false) {
  color(freezer_color) {
    // Freezer body
    difference() {
      cube([FREEZER_WIDTH, FREEZER_DEPTH, FREEZER_BODY_HEIGHT], center=true);

      translate([0, 0, FREEZER_WALL_THICKNESS])
      cube([
        FREEZER_WIDTH - (2 * FREEZER_WALL_THICKNESS),
        FREEZER_DEPTH - (2 * FREEZER_WALL_THICKNESS),
        FREEZER_BODY_HEIGHT - FREEZER_WALL_THICKNESS
      ], center=true);
    }



    // TODO figure out how to do this for real
    open_rotation =  open ? [-45, 0, 0] : [0, 0, 0];
    open_translation = open ? [
      0,
      FREEZER_DEPTH * -0.35,
      (FREEZER_BODY_HEIGHT * 0.48) - FREEZER_LID_HEIGHT
    ] : [0, 0, 0];

    translate(open_translation)
    rotate(open_rotation)
      union() {
        // Freezer lid
        translate([
          0,
          0,
          (FREEZER_BODY_HEIGHT / 2) +
            ((FREEZER_LID_HEIGHT - FREEZER_LID_SEAL_HEIGHT) / 2) +
            FREEZER_LID_SEAL_HEIGHT,
        ])
          cube([FREEZER_WIDTH, FREEZER_DEPTH, FREEZER_LID_HEIGHT - FREEZER_LID_SEAL_HEIGHT], center=true);

        // Freezer lid seal
        translate([
          0,
          0,
          (FREEZER_BODY_HEIGHT / 2) + (FREEZER_LID_SEAL_HEIGHT / 2)
        ])
          cube([
            FREEZER_WIDTH - (1 * INCH),
            FREEZER_DEPTH - (1 * INCH),
            FREEZER_LID_SEAL_HEIGHT
          ], center=true);
      }
  }
}
