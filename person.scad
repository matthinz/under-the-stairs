include <utils.scad>;

module person(
  height = 5 * FEET,
  depth = 6 * INCHES,
) {


  head_r = (height * (1/8)) / 2;
  person_width = 12 * INCHES;
  person_depth = 6 * INCHES;
  torso_height = (height - (head_r * 2)) * .54;
  leg_height = (height - (head_r * 2) - torso_height);
  leg_width = person_width / 4;

translate([0, head_r, height - head_r])
  sphere(head_r);

translate([
  0,
  person_depth / 2,
  (torso_height / 2) + leg_height,
])
cube([
  12 * INCHES,
  person_depth,
  torso_height
], center = true);


// left leg
translate(
  [
    (person_width / -2) + leg_width/2,
    person_depth / 2,
    leg_height / 2
  ]
)
cube(
  [
    leg_width,
    person_depth,
    leg_height
  ],
  center = true
);

// right leg
translate(
  [
    (person_width / 2) - leg_width/2,
    person_depth / 2,
    leg_height / 2
  ]
)
cube(
  [
    leg_width,
    person_depth,
    leg_height
  ],
  center = true
);


}
