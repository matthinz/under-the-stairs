INCH = 1;
INCHES = INCH;
FOOT = 12 * INCHES;
FEET = FOOT;

X = 0;
Y = 1;

QUOTE_TWO = 1.5 * INCHES;
QUOTE_FOUR = 3.5 * INCHES;

module cube_at(point, size) {
  translate(point)
    translate(size / 2)
      cube(size, center = true);
}


function sum(v, i = 0) = i < len(v) ? v[i] + sum(v, i + 1) : 0;
