include <current.scad>;
include <utils.scad>;

module simple() {

  color("Black") {
    translate([
      0,
      0,
      TALL_WALL_HEIGHT + 12 * INCHES
    ])
    rotate([90, 0, 0])
      text("Simple");
  }

  subfloor();

  walls_and_ceiling();

  current_power_outlet();

  flooring(gap_for_divider_wall = false);

  translate([
    (LITTER_BOX_WIDTH / 2) +
      DRYWALL_THICKNESS +
        TOTAL_WIDTH - LITTER_BOX_WIDTH - DRYWALL_THICKNESS
        - (2 * INCHES),
    (LITTER_BOX_DEPTH / 2) +
      TOTAL_DEPTH - LITTER_BOX_DEPTH - (2 * INCHES),
    (LITTER_BOX_HEIGHT / 2) +
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT,
  ])
    rotate([0, 0, 180])
      litter_box();
}
