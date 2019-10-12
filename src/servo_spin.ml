open Core
open Import

let run () =
  let run servo =
    for d = 0 to 100 do
      Servo.set_direction servo ((2. *. float_of_int d /. 100.) -. 1.);
      ignore (Unix.nanosleep 0.01 : float)
    done;
    Servo.set_direction servo 0.
  in
  run Servo.sonar;
  run Servo.steering

let command = no_arg_command "Exercise the sonic servo" run
