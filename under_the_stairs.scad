include <utils.scad>;
include <litter_box.scad>;

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

TALL_WALL_HEIGHT = (77 + (5/8)) * INCHES;

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

module subfloor(subfloor_color = "Gray") {

  color(subfloor_color) {

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
}

module walls_and_ceiling(paint_color = "LemonChiffon") {

  color(paint_color) {

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
        FLOORING_THICKNESS + TALL_WALL_HEIGHT
      ]
    );


    // sticky-outy part
    cube_at(
      point = [
        0,
        -HALLWAY_SIDE_STICKY_OUTY_PART_DEPTH,
        0
      ],
      size = [
        DRYWALL_THICKNESS,
        HALLWAY_SIDE_STICKY_OUTY_PART_DEPTH,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS + TALL_WALL_HEIGHT
      ]
    );

    // Short wall
    cube_at(
      point = [
        DRYWALL_THICKNESS + TOTAL_WIDTH,
        0,
        SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT - FLOORING_THICKNESS
      ],
      size = [
        DRYWALL_THICKNESS,
        TOTAL_DEPTH,
        FLOORING_THICKNESS + SHORT_WALL_HEIGHT + DRYWALL_THICKNESS
      ]
    );

    // Ceiling
    TALL_WALL_HEIGHT_FROM_ORIGIN = TALL_WALL_HEIGHT + SUBFLOOR_THICKNESS + FLOORING_THICKNESS;
    SHORT_WALL_HEIGHT_FROM_ORIGIN = SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + FLOORING_THICKNESS + SHORT_WALL_HEIGHT;

    // viewed from hallway side
    nw_front = [DRYWALL_THICKNESS, 0, TALL_WALL_HEIGHT_FROM_ORIGIN + DRYWALL_THICKNESS];
    nw_back = [DRYWALL_THICKNESS, TOTAL_DEPTH, TALL_WALL_HEIGHT_FROM_ORIGIN + DRYWALL_THICKNESS];

    ne_front = [DRYWALL_THICKNESS + TOTAL_WIDTH, 0, SHORT_WALL_HEIGHT_FROM_ORIGIN + DRYWALL_THICKNESS];
    ne_back = [DRYWALL_THICKNESS + TOTAL_WIDTH, TOTAL_DEPTH, SHORT_WALL_HEIGHT_FROM_ORIGIN + DRYWALL_THICKNESS];

    se_front = [DRYWALL_THICKNESS + TOTAL_WIDTH, 0, SHORT_WALL_HEIGHT_FROM_ORIGIN];
    se_back = [DRYWALL_THICKNESS + TOTAL_WIDTH, TOTAL_DEPTH, SHORT_WALL_HEIGHT_FROM_ORIGIN];

    sw_front = [DRYWALL_THICKNESS, 0, TALL_WALL_HEIGHT_FROM_ORIGIN];
    sw_back = [DRYWALL_THICKNESS, TOTAL_DEPTH, TALL_WALL_HEIGHT_FROM_ORIGIN];


    _nw_front = 0;
    _nw_back = 1;
    _ne_front = 2;
    _ne_back = 3;
    _se_front = 4;
    _se_back = 5;
    _sw_front = 6;
    _sw_back = 7;

    top_face = [_nw_front, _nw_back, _ne_back, _ne_front];
    bottom_face = [_sw_back, _sw_front, _se_front, _se_back];
    front_face = [_nw_front, _ne_front, _se_front, _sw_front];
    back_face = [_ne_back, _nw_back, _sw_back, _se_back];
    right_face = [_ne_front, _ne_back, _se_back, _se_front];
    left_face = [_nw_back, _nw_front, _sw_front, _sw_back];

    polyhedron(
      points = [
        nw_front,
        nw_back,
        ne_front,
        ne_back,
        se_front,
        se_back,
        sw_front,
        sw_back,
      ],
      faces = [
        top_face,
        bottom_face,
        front_face,
        back_face,
        left_face,
        right_face,
      ],
      convexity = 2
    );
  }
}

module flooring(flooring_color = "Sienna") {

  color(flooring_color) {

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
}

module divider_wall(divider_wall_color = "Peru") {

  color(divider_wall_color) {

    divider_wall_y = HALLWAY_SIDE_DEPTH;
    tall_wall_top_z = SUBFLOOR_THICKNESS + FLOORING_THICKNESS + TALL_WALL_HEIGHT;
    short_wall_top_z = SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + SHORT_WALL_HEIGHT;
    short_wall_bottom_z = SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT;
    short_wall_x = DRYWALL_THICKNESS + TOTAL_WIDTH;

    nw_front = [ DRYWALL_THICKNESS, divider_wall_y, tall_wall_top_z];
    nw_back = [ DRYWALL_THICKNESS, divider_wall_y + DIVIDER_WALL_THICKNESS, short_wall_bottom_z];

    ne_front = [short_wall_x, divider_wall_y, short_wall_top_z];
    ne_back = [short_wall_x, divider_wall_y + DIVIDER_WALL_THICKNESS, short_wall_top_z];

    se_front = [ short_wall_x, divider_wall_y, short_wall_bottom_z];
    se_back = [ short_wall_x, divider_wall_y + DIVIDER_WALL_THICKNESS, short_wall_bottom_z];

    sw_front = [ DRYWALL_THICKNESS, divider_wall_y,  short_wall_bottom_z];
    sw_back = [ DRYWALL_THICKNESS, divider_wall_y + DIVIDER_WALL_THICKNESS, short_wall_bottom_z];

    _nw_front = 0;
    _nw_back = 1;
    _ne_front = 2;
    _ne_back = 3;
    _se_front = 4;
    _se_back = 5;
    _sw_front = 6;
    _sw_back = 7;

    front_face =  [_nw_front, _ne_front, _se_front, _sw_front];
    back_face =   [_ne_back, _nw_back, _sw_back, _se_back];
    left_face =   [_nw_back, _nw_front, _sw_front, _sw_back, ];
    right_face =  [_ne_front, _ne_back, _se_back, _se_front];
    top_face =    [_nw_front, _nw_back,  _ne_back, _ne_front, ];
    bottom_face = [_sw_front, _se_front, _se_back, _sw_back];

    door_point =  [
      DRYWALL_THICKNESS + 4 * INCHES,
      divider_wall_y,
      short_wall_bottom_z + FLOORING_THICKNESS + 18.5 * INCHES,
    ];

    door_size = [
      12 * INCHES,
      DIVIDER_WALL_THICKNESS,
      (32 + (7/8)) * INCHES,
    ];


    difference() {
      polyhedron(
        points = [
          nw_front,
          nw_back,
          ne_front,
          ne_back,
          se_front,
          se_back,
          sw_front,
          sw_back,
        ],
        faces = [
          front_face,
          back_face,
          left_face,
          right_face,
          top_face,
          bottom_face,
        ],
        convexity = 1
      );

      cube_at(
        point = [
          door_point[0],
          door_point[1] - (1 * INCHES),
          door_point[2],
        ],
        size = [
          door_size[0],
          door_size[1] + (2 * INCHES),
          door_size[2],
        ]
      );
    }


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
  }
}

module current() {

  color("Black") {
    translate([
      0,
      0,
      TALL_WALL_HEIGHT + 12 * INCHES
    ])
    rotate([90, 0, 0])
      text("Current");
  }

  subfloor();

  walls_and_ceiling();

  flooring();

  divider_wall();

  translate([
    (LITTER_BOX_DEPTH / 2) + DRYWALL_THICKNESS + (2*INCHES),
    (LITTER_BOX_WIDTH / 2) + HALLWAY_SIDE_DEPTH + DIVIDER_WALL_THICKNESS + (2 * INCHES),
    SUBFLOOR_THICKNESS + FLOORING_THICKNESS + SUNKEN_AREA_HEIGHT + (LITTER_BOX_HEIGHT / 2),
  ])
    rotate([0, 0, 90])
    litter_box();
}


translate([TOTAL_WIDTH * -1.5, 0, 0])
  current();

  subfloor();

  walls_and_ceiling();
