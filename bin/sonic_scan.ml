open! Core
open! Import

let run () =
  Led.set_rgb false true true;
  for d = 0 to 100 do
    Servo.set_direction Servo.sonar ((2. *. float_of_int d /. 100.) -. 1.);
    let sonic = Sonic.get_distance () in
    Printf.printf "%2d %f\n%!" d sonic;
    ignore (Unix.nanosleep 0.01 : float)
  done;
  Servo.set_direction Servo.sonar 0.;
  Led.set_rgb true true true

let command =
  no_arg_command
    "Do a sonic scan while swinging the scanner back and forth"
    run
