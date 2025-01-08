include <books.scad>;
include <current.scad>;

module hidden_room() {

  color("Black") {
    translate([
      3 * INCHES,
      0,
      TALL_WALL_HEIGHT + 12 * INCHES
    ])
    rotate([90, 0, 0])
      text("Hidden room");
  }


  subfloor();

  walls_and_ceiling();

  flooring(gap_for_divider_wall = false);

  color("LemonChiffon") {

    // side wall
    difference() {
      cube_at(
        point = [
          DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
          0,
          SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT - (1/16 * INCH),
        ],
        size = [
          WALL_THICKNESS,
          TOTAL_DEPTH,
          TALL_WALL_HEIGHT - SUNKEN_AREA_HEIGHT
        ]
      );

      door_width = SUNKEN_AREA_WIDTH + FLOORING_THICKNESS - WALL_THICKNESS - (DRYWALL_THICKNESS + QUOTE_TWO);

      cube_at(
        point = [
          (DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS) - (1 * INCH),
          DRYWALL_THICKNESS + QUOTE_TWO,
          SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + (1/16 * INCH)
        ],
        size = [
          WALL_THICKNESS + (2 * INCH),
          door_width,
          18 * INCHES
        ]
      );
    }

    // entry side wall
    cube_at(
      point = [
        DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS + WALL_THICKNESS,
        TOTAL_DEPTH - WALL_THICKNESS,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT
      ],
      size = [
        TOTAL_WIDTH - SUNKEN_AREA_WIDTH - FLOORING_THICKNESS - WALL_THICKNESS,
        WALL_THICKNESS,
        TALL_WALL_HEIGHT - SUNKEN_AREA_HEIGHT
      ]
    );

    // sunken area rear wall
    cube_at(
      point = [
        DRYWALL_THICKNESS,
        HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - THIN_WALL_THICKNESS,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS
      ],
      size = [
        SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
        THIN_WALL_THICKNESS,
        TALL_WALL_HEIGHT
      ]
    );
  }

  color("LemonChiffon", 0.7) {

    // hall side wall
    cube_at(
      point = [
        DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS + WALL_THICKNESS,
        (1/8) * INCH,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT
      ],
      size = [
        TOTAL_WIDTH - SUNKEN_AREA_WIDTH - FLOORING_THICKNESS - THIN_WALL_THICKNESS,
        THIN_WALL_THICKNESS,
        TALL_WALL_HEIGHT - SUNKEN_AREA_HEIGHT
      ]
    );

  }

  current_power_outlet();

  shelf_inset = 2 * INCHES;

  module shelves(
    point,
    count,
    height = (1/2) * INCHES,
    available_height,
    width,
    depth,
  ) {

    offset = available_height - (count * height);

    for (i = [0 : count - 1]) {
      cube_at(
        point = [
          point[0],
          point[1],
          point[2] + (offset * i),
        ],
        size = [
          width,
          depth,
          height
        ]
      );
    }
  }

  // hall-side shelves
  shelves(
    count = 3,
    width = SUNKEN_AREA_WIDTH,
    depth = HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - THIN_WALL_THICKNESS - shelf_inset,
    point = [
      DRYWALL_THICKNESS,
      shelf_inset,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + (20 * INCHES),
    ],
    available_height = 1.5 * FEET
  );

  // entry-side shelves
  color("Peru") {
    shelf_inset = 2 * INCHES;
    shelf_depth = ENTRY_SIDE_DEPTH - shelf_inset;
  }


  // Put some books on the shelves
  shelf_depth = HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM - THIN_WALL_THICKNESS - shelf_inset;
  translate([
    DRYWALL_THICKNESS + (BOOKS_WIDTH / 2),
    (BOOKS_DEPTH / 2) + shelf_inset + (shelf_depth - BOOKS_DEPTH),
    (BOOKS_HEIGHT / 2) +
      SUBFLOOR_THICKNESS +
      FLOORING_THICKNESS +
      SUNKEN_AREA_HEIGHT + (20.5 * INCHES),
  ])
    books();

  translate([
    (LITTER_BOX_WIDTH / 2) + DRYWALL_THICKNESS + 4 * INCHES,
    (LITTER_BOX_DEPTH / 2) + TOTAL_DEPTH - (LITTER_BOX_DEPTH + 2 * INCHES),
    (LITTER_BOX_HEIGHT / 2) + SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT
  ])
    rotate([0, 0, 180])
    litter_box();
}
