include <utils.scad>;

BOOK_SIZES = [
    [
      (1 + (5/8)) * INCHES,
      (6 + (7/8)) * INCHES,
      (9 + (1/4)) * INCHES,
    ],
    [
        (2 + (5/8)) * INCHES,
        6 * INCHES,
        8 * INCHES,
    ],
    [
      (1 + (5/8)) * INCHES,
      (6 + (7/8)) * INCHES,
      (5 + (1/4)) * INCHES,
    ],

];

BOOK_COLORS = [
  "Red",
  "Orange",
  "Gray",
];

BOOK_SEPARATION = (1/8) * INCHES;

BOOKS_WIDTH = sum([for (size = BOOK_SIZES) size[0]]) + (BOOK_SEPARATION * (len(BOOK_SIZES) - 1));
BOOKS_HEIGHT = max([for (size = BOOK_SIZES) size[2] ]);
BOOKS_DEPTH = max([for (size = BOOK_SIZES) size[1]]);

module books() {

  tallest = max([for (size = BOOK_SIZES) size[2]]);
  deepest = max([for (size = BOOK_SIZES) size[1]]);

  for (i = [0 : len(BOOK_SIZES) - 1]) {
    size = BOOK_SIZES[i];

    width_so_far = i == 0 ?
      0 :
      sum([for (j = [0 : i - 1]) BOOK_SIZES[j][0] + BOOK_SEPARATION]);



    color(BOOK_COLORS[i]) {
      translate([
          (BOOKS_WIDTH / -2) + width_so_far + (size[0] / 2),
          (deepest - size[1]) / 2,
          (tallest - size[2]) / -2
      ])
        cube(
          size,
          center = true
        );
    }
  }
}
