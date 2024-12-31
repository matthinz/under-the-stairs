
INCHES = 1;

width = 66 * INCHES;

drywall_thickness = (1/2) * INCHES;
flooring_thickness = (1/2) * INCHES;

tall_wall_height = (70 + (1/2)) * INCHES;
short_wall_height = (19 + (7/8)) * INCHES;

hallway_side_depth = (22 + (3/8)) * INCHES;
entry_side_depth = (21 + (3/8)) * INCHES;

divider_wall_thickness = (3/4) * INCHES;

step_height = (6 + (1/8)) * INCHES;
step_width = 21 * INCHES;

hall_side_floor_width = width - step_width - flooring_thickness;

hall_side_sticky_outy_part_depth = 2 * INCHES;
hall_side_sticky_outy_part_extra_height = 2 * INCHES;

total_depth = hallway_side_depth + entry_side_depth + divider_wall_thickness;

rotate([0,0,$t]) {

  color("red") {
      // Step surface
      translate([(step_width / 2) + drywall_thickness, hallway_side_depth / 2, flooring_thickness / 2])
        cube([step_width, hallway_side_depth, flooring_thickness], center=true);

  }
    // Step walls
  color("purple") {
    translate([drywall_thickness / 2, hallway_side_depth / 2, flooring_thickness + step_height / 2])
      cube([drywall_thickness, hallway_side_depth, step_height], center=true);



    translate([drywall_thickness + (step_width / 2), (flooring_thickness/2) + hallway_side_depth, flooring_thickness + step_height / 2])
      cube([step_width, flooring_thickness, step_height], center=true);

    translate([drywall_thickness + (flooring_thickness / 2) + step_width, hallway_side_depth / 2, flooring_thickness + step_height / 2])
      cube([flooring_thickness, hallway_side_depth, step_height], center=true);
  }

  // Hall side floor
  translate([
    (hall_side_floor_width / 2) + drywall_thickness + step_width + flooring_thickness,
    hallway_side_depth / 2,
    (flooring_thickness / 2)+ step_height
  ])
    cube([hall_side_floor_width, hallway_side_depth, flooring_thickness], center=true);

  // Tall wall
  color("blue") {
    translate([drywall_thickness/2, total_depth/2, (tall_wall_height/2) + flooring_thickness + step_height])
      cube([drywall_thickness, total_depth, tall_wall_height], center=true);

    // sticky-outy part
    translate([
      drywall_thickness / 2,
      (hall_side_sticky_outy_part_depth / 2) * -1,
      (tall_wall_height + step_height + hall_side_sticky_outy_part_extra_height) / 2
    ])
    cube([drywall_thickness, hall_side_sticky_outy_part_depth, tall_wall_height + step_height + hall_side_sticky_outy_part_extra_height], center=true);
  }

  // Short wall
  translate([width + drywall_thickness * 1.5, total_depth/2, (short_wall_height/2) + flooring_thickness + step_height])
    cube([drywall_thickness, total_depth, short_wall_height], center=true);

  // Ceiling
  color("green") {
    translate([0, 0, step_height])
      polyhedron([
        // Short wall
        [drywall_thickness + width, 0, flooring_thickness + short_wall_height],
        [drywall_thickness + width, total_depth, flooring_thickness + short_wall_height],

        // Tall wall
        [drywall_thickness, 0, tall_wall_height + flooring_thickness],
        [drywall_thickness, total_depth, tall_wall_height + flooring_thickness],


        // Short wall
        [drywall_thickness + width, 0, flooring_thickness + short_wall_height + drywall_thickness],
        [drywall_thickness + width, total_depth, flooring_thickness + short_wall_height + drywall_thickness],

        // Tall wall
        [drywall_thickness, 0, tall_wall_height + flooring_thickness + drywall_thickness],
        [drywall_thickness, total_depth, tall_wall_height + flooring_thickness + drywall_thickness],

      ], faces = [
        [0, 1, 2, 3],
        [4, 5, 6, 7],
        [0,1,5,4],
        [0,4,2,6],
        [1,5,4,7],
        [2,3,7,6]
      ]);
  }

  // Divider wall
  // color("brown") {
  //  polyhedron(
  //   points=[
  //     // hall side
  //     [drywall_thickness, hallway_side_depth, flooring_thickness],
  //     [drywall_thickness + width, hallway_side_depth, flooring_thickness],
  //     [drywall_thickness + width, hallway_side_depth, flooring_thickness + short_wall_height],
  //     [drywall_thickness, hallway_side_depth, flooring_thickness + tall_wall_height],

  //     // entry side
  //     [drywall_thickness, hallway_side_depth + divider_wall_thickness, flooring_thickness],
  //     [drywall_thickness + width, hallway_side_depth + divider_wall_thickness, flooring_thickness],
  //     [drywall_thickness + width, hallway_side_depth + divider_wall_thickness, flooring_thickness + short_wall_height],
  //     [drywall_thickness, hallway_side_depth + divider_wall_thickness, flooring_thickness + tall_wall_height],

  //   ],
  //   faces = [
  //     [0,1,2,3],
  //     [4,5,6,7],
  //   ]);
  // }
}
