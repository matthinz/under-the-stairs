INCHES = 1;

TOTAL_WIDTH = 66 * INCHES;

DRYWALL_THICKNESS = (1/2) * INCHES;
FLOORING_THICKNESS = (3/8) * INCHES;
SUBFLOOR_THICKNESS = (7/8) * INCHES;
DIVIDER_WALL_TRIM_THICKNESS = (5/8) * INCHES;

ENTRY_SIDE_DEPTH = (21 + (3/8)) * INCHES;
DIVIDER_WALL_THICKNESS = (3/4) * INCHES;
DIVIDER_WALL_TRIM = 1.5 * INCHES;
HALLWAY_SIDE_DEPTH = (22 + (3/8)) * INCHES;

TOTAL_DEPTH = ENTRY_SIDE_DEPTH + HALLWAY_SIDE_DEPTH + DIVIDER_WALL_THICKNESS;

SUNKEN_AREA_HEIGHT = (6 + (1/8)) * INCHES;
SUNKEN_AREA_WIDTH = 21 * INCHES;

TALL_WALL_HEIGHT = (70 + (1/2)) * INCHES;
TALL_WALL_HEIGHT_FROM_ORIGIN = TALL_WALL_HEIGHT + SUBFLOOR_THICKNESS + FLOORING_THICKNESS;

SHORT_WALL_HEIGHT = (19 + (7/8)) * INCHES;
SHORT_WALL_HEIGHT_FROM_ORIGIN = SUBFLOOR_THICKNESS + SUNKEN_AREA_HEIGHT + SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SHORT_WALL_HEIGHT;

HALLWAY_SIDE_STICKY_OUTY_PART_DEPTH = 2 * INCHES;

module cube_at_origin(size) {
  translate([size[0] / 2, size[1] / 2, size[2] / 2])
    cube(size, center=true);
}

module cube_at(point, size) {
  translate(point)
    cube_at_origin(size);
}

module cube_at_points(nw, ne, se, sw, thickness) {
  polyhedron(
    // move clockwise starting from nw
    points = [
      /* 0 */ nw,
      /* 1 */ [nw[0], nw[1], nw[2] + thickness],
      /* 2 */ ne,
      /* 3 */ [ne[0], ne[1], ne[2] + thickness],
      /* 4 */ se,
      /* 5 */ [se[0], se[1], se[2] + thickness],
      /* 6 */ sw,
      /* 7 */ [sw[0], sw[1], sw[2] + thickness],
    ],
    faces = [
      // NW -> SW
      [0, 1, 6, 7],
      // NW -> NE
      [0, 1, 2, 3],
      // NE -> SE
      [2, 3, 4, 5],
      // SE -> SW
      [4, 5, 6, 7],
      // Bottom
      [0, 2, 4, 6],
      // top
      [1, 3, 5, 7],
    ]
  );
}

module subfloor() {

  // Floor above sunken area
  cube_at(
    point = [
      0,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT - FLOORING_THICKNESS - SUBFLOOR_THICKNESS,
    ],
    size = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
      ENTRY_SIDE_DEPTH + DIVIDER_WALL_TRIM + DIVIDER_WALL_THICKNESS,
      SUBFLOOR_THICKNESS

    ]
  );


  // Sunken area side wall
  cube_at(
    point = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
      0,
      SUBFLOOR_THICKNESS
    ],
    size = [
      SUBFLOOR_THICKNESS,
      HALLWAY_SIDE_DEPTH - FLOORING_THICKNESS - SUBFLOOR_THICKNESS,
      SUNKEN_AREA_HEIGHT - SUBFLOOR_THICKNESS
    ]
  );

  // Sunken area rear wall
  cube_at(
    point = [
      0,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      SUBFLOOR_THICKNESS
    ],
    size = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS + SUBFLOOR_THICKNESS,
      SUBFLOOR_THICKNESS,
      SUNKEN_AREA_HEIGHT - SUBFLOOR_THICKNESS
    ]
  );

  // Sunken area floor
  cube_at(
    point = [
      0,
      0,
      0,
    ],
    size = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS + SUBFLOOR_THICKNESS,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM  + SUBFLOOR_THICKNESS,
      SUBFLOOR_THICKNESS
    ]
  );

  // Big piece under short wall
  cube_at(
    point = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
      0,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT - FLOORING_THICKNESS - SUBFLOOR_THICKNESS
    ],
    size = [
      TOTAL_WIDTH - SUNKEN_AREA_WIDTH - FLOORING_THICKNESS + DRYWALL_THICKNESS,
      HALLWAY_SIDE_DEPTH + DIVIDER_WALL_THICKNESS + ENTRY_SIDE_DEPTH,
      SUBFLOOR_THICKNESS,
    ]
  );


}

module walls_and_ceiling() {
  // Tall wall
  cube_at(
    point = [
      0,
      0,
      SUBFLOOR_THICKNESS
    ],
    size = [
      DRYWALL_THICKNESS,
      TOTAL_DEPTH,
      TALL_WALL_HEIGHT
    ]
  );

  translate([0, 0, SUBFLOOR_THICKNESS])
    cube_at_origin([DRYWALL_THICKNESS, HALLWAY_SIDE_DEPTH, SUNKEN_AREA_HEIGHT])

  // sticky-outy part
  translate([0, -HALLWAY_SIDE_STICKY_OUTY_PART_DEPTH, SUBFLOOR_THICKNESS])
    cube_at_origin([DRYWALL_THICKNESS, HALLWAY_SIDE_STICKY_OUTY_PART_DEPTH, TALL_WALL_HEIGHT + SUNKEN_AREA_HEIGHT]);

  // Short wall
  translate([DRYWALL_THICKNESS + TOTAL_WIDTH, 0, SUBFLOOR_THICKNESS + SUNKEN_AREA_HEIGHT])
    cube_at_origin([DRYWALL_THICKNESS, TOTAL_DEPTH, SHORT_WALL_HEIGHT + FLOORING_THICKNESS]);

  // Ceiling
  cube_at_points(
    nw = [DRYWALL_THICKNESS, 0, TALL_WALL_HEIGHT_FROM_ORIGIN],
    ne = [DRYWALL_THICKNESS, TOTAL_DEPTH, TALL_WALL_HEIGHT_FROM_ORIGIN],
    sw = [DRYWALL_THICKNESS + TOTAL_WIDTH, 0, SHORT_WALL_HEIGHT_FROM_ORIGIN],
    se = [DRYWALL_THICKNESS + TOTAL_WIDTH, TOTAL_DEPTH, SHORT_WALL_HEIGHT_FROM_ORIGIN],
    thickness = DRYWALL_THICKNESS
  );

}

module flooring() {

  // Floor of sunken area
  cube_at(
    point = [
      DRYWALL_THICKNESS,
      0,
      SUBFLOOR_THICKNESS
    ],
    size = [
      SUNKEN_AREA_WIDTH + FLOORING_THICKNESS,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      FLOORING_THICKNESS
    ]
  );

  // Sunken area rear wall
  cube_at(
    point = [
      DRYWALL_THICKNESS,
      (HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM) - FLOORING_THICKNESS,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS,
    ],
    size = [
      SUNKEN_AREA_WIDTH,
      FLOORING_THICKNESS,
      SUNKEN_AREA_HEIGHT
    ]
  );

  // Sunken area side wall
  cube_at(
    point = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH,
      0,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS
    ],
    size = [
      FLOORING_THICKNESS,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      SUNKEN_AREA_HEIGHT - FLOORING_THICKNESS
    ]
  );

  // Floor of hallway side
  cube_at(
    point = [
      DRYWALL_THICKNESS + SUNKEN_AREA_WIDTH,
      0,
      SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT - FLOORING_THICKNESS
    ],
    size = [
      TOTAL_WIDTH - SUNKEN_AREA_WIDTH,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      FLOORING_THICKNESS
    ]
  );

  // Divider wall trim (hallway side)
  cube_at(
    point = [
      DRYWALL_THICKNESS,
      HALLWAY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      SUBFLOOR_THICKNESS + SUNKEN_AREA_HEIGHT
    ],
    size = [
      TOTAL_WIDTH,
      DIVIDER_WALL_TRIM,
      DIVIDER_WALL_TRIM_THICKNESS
    ]
  );

  // Divider wall trim (entry side)
  cube_at(
    point = [
      DRYWALL_THICKNESS,
      HALLWAY_SIDE_DEPTH + DIVIDER_WALL_THICKNESS,
      SUBFLOOR_THICKNESS + SUNKEN_AREA_HEIGHT
    ],
    size = [
      TOTAL_WIDTH,
      DIVIDER_WALL_TRIM,
      DIVIDER_WALL_TRIM_THICKNESS
    ]
  );

  // Floor of entry side
  cube_at(
    point = [
      DRYWALL_THICKNESS,
      HALLWAY_SIDE_DEPTH + DIVIDER_WALL_THICKNESS + DIVIDER_WALL_TRIM,
      SUBFLOOR_THICKNESS + SUNKEN_AREA_HEIGHT,
    ],
    size = [
      TOTAL_WIDTH,
      ENTRY_SIDE_DEPTH - DIVIDER_WALL_TRIM,
      FLOORING_THICKNESS
    ]
  );

}


#color("gray") {
  subfloor();
}

color("LemonChiffon") {
  walls_and_ceiling();
}

color("Sienna") {
  flooring();
}
