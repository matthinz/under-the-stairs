include <utils.scad>;
include <current.scad>;
include <freezer.scad>;
include <hidden_room.scad>;
include <litter_box.scad>;
include <person.scad>;




module utilitarian() {

  color("Black") {
    translate([
      0,
      0,
      TALL_WALL_HEIGHT + 12 * INCHES
    ])
    rotate([90, 0, 0])
      text("Utilitarian");
  }

  subfloor();

  walls_and_ceiling();

  flooring(gap_for_divider_wall = false);

  translate([
    (LITTER_BOX_WIDTH / 2) + TOTAL_WIDTH - (LITTER_BOX_WIDTH + 2 * INCHES),
    (LITTER_BOX_DEPTH / 2) + TOTAL_DEPTH - (LITTER_BOX_DEPTH + 2 * INCHES),
    (LITTER_BOX_HEIGHT / 2) + SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT
  ])
  rotate([0, 0, 180])
    litter_box();

  translate([
    (FREEZER_WIDTH / 2) + DRYWALL_THICKNESS + (2 * INCHES),
    (FREEZER_DEPTH / 2) + TOTAL_DEPTH - FREEZER_DEPTH,
    (FREEZER_HEIGHT / 2) + SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT
  ])
    rotate([0, 0, 180])
    freezer(open = true);

  // New divider wall

  divider_wall(
    divider_wall_color = "LemonChiffon",
    door = false,
    thickness = DRYWALL_THICKNESS + QUOTE_TWO + DRYWALL_THICKNESS,
    trim = false,
    y = HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - QUOTE_FOUR - (6 * INCHES) - DRYWALL_THICKNESS
  );

  color("LemonChiffon") {
    cube_at(
      point = [
        DRYWALL_THICKNESS,
        HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - QUOTE_FOUR - (6 * INCHES) - DRYWALL_THICKNESS,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS,
      ],
      size = [
        SUNKEN_AREA_WIDTH,
        DRYWALL_THICKNESS,
        SUNKEN_AREA_HEIGHT
      ]
    );
  }

  shelf_inset = 2 * INCHES;
  shelf_depth = HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - (6 * INCHES) - DRYWALL_THICKNESS - QUOTE_FOUR - DRYWALL_THICKNESS - shelf_inset;
  shelf_height = 12 * INCHES;

  shelf_start_z = SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + shelf_height;

  shelf_thickness = (1/2) * INCH;

  color("Peru") {
    cube_at(
      point = [
        DRYWALL_THICKNESS,
        shelf_inset,
        shelf_start_z,
      ],
      size = [
        TOTAL_WIDTH,
        shelf_depth,
        shelf_thickness
      ]
    );

    cube_at(
      point = [
        DRYWALL_THICKNESS,
        shelf_inset,
        shelf_start_z + (shelf_thickness + shelf_height) * 1,
      ],
      size = [
        TOTAL_WIDTH,
        shelf_depth,
        shelf_thickness
      ]
    );

    cube_at(
      point = [
        DRYWALL_THICKNESS,
        shelf_inset,
        shelf_start_z + (shelf_thickness + shelf_height) * 2,
      ],
      size = [
        TOTAL_WIDTH,
        shelf_depth,
        shelf_thickness
      ]
    );

    cube_at(
      point = [
        DRYWALL_THICKNESS,
        shelf_inset,
        shelf_start_z + (shelf_thickness + shelf_height) * 3,
      ],
      size = [
        TOTAL_WIDTH,
        shelf_depth,
        shelf_thickness
      ]
    );
  }
}


color("Black") {
  translate([-2.5 * FEET, -2 * FOOT, 0])
    text("Hallway", size = 1 * FOOT);

  translate([1.5 * FEET, TOTAL_DEPTH + 2 * FEET, 0])
    rotate([0, 0, 180])
    text("Entry", size = 1 * FOOT);

}

translate([
  (TOTAL_WIDTH / -2) - (TOTAL_WIDTH * 1.5),
  0,
  0
])
  current();

translate([TOTAL_WIDTH / -2, 0, 0])
  hidden_room();

translate([
  (TOTAL_WIDTH / -2) + (TOTAL_WIDTH * 1.5),
  0,
  0
])
  utilitarian();

translate([
  TOTAL_WIDTH * -.75,
  0,
  SUBFLOOR_THICKNESS + FLOORING_THICKNESS
])
  person();
