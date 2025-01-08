include <current.scad>;
include <freezer.scad>;
include <hidden_room.scad>;
include <litter_box.scad>;
include <person.scad>;
include <simple.scad>;
include <utilitarian.scad>;
include <utils.scad>;


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

translate([ TOTAL_WIDTH / -2, 0, 0 ])
  simple();

translate([
  (TOTAL_WIDTH / -2) + (TOTAL_WIDTH * 1.5),
  0,
  0
])
  utilitarian();

translate([
  (TOTAL_WIDTH / -2) + TOTAL_WIDTH * 3,
  0,
  0
])
  hidden_room();


translate([
  TOTAL_WIDTH * -.75,
  0,
  SUBFLOOR_THICKNESS + FLOORING_THICKNESS
])
  person();
