open Core
open Mdev

let no_arg_command summary f = Command.basic ~summary (Command.Param.return f)

let forward =
  no_arg_command "Move the robot forward" (fun () ->
      Motor.set_speed Motor.left 1000;
      Motor.set_speed Motor.right 1000;
      Unix.sleep 1;
      Motor.set_speed Motor.left 0;
      Motor.set_speed Motor.right 0)

let buzzer =
  no_arg_command "Make some noise!" (fun () ->
      Buzzer.set_level 3000;
      Unix.sleep 1;
      Buzzer.set_level 0)

let blink =
  no_arg_command "Blink the LED" (fun () ->
      Led.set_rgb false true true;
      Unix.sleep 1;
      Led.set_rgb true false true;
      Unix.sleep 1;
      Led.set_rgb true true false;
      Unix.sleep 1;
      Led.set_rgb true true true)

let sonic_scan =
  no_arg_command "Do a sonic scan while swinging the scanner back and forth" (fun () ->
      Led.set_rgb false true true;
      for d = 0 to 100 do
        Servo.set_direction Servo.sonar (float_of_int d /. 100.);
        let sonic = Sonic.get_distance () in
        Printf.printf "%2d %f\n%!" d sonic;
        ignore (Unix.nanosleep 0.01 : float)
      done;
      Servo.set_direction Servo.sonar 0.5;
      Led.set_rgb true true true)

let sonic =
  no_arg_command "Grab a bunch of measurements from the sonic sensor" (fun () ->
      for d = 0 to 25 do
        let sonic = Mdev.Sonic.get_distance () in
        Printf.printf "%2d %f\n%!" d sonic;
        ignore (Unix.nanosleep 0.04 : float)
      done)

let servo =
  no_arg_command "Exercise the sonic servo" (fun () ->
      for d = 0 to 100 do
        Servo.set_direction Servo.sonar (float_of_int d /. 100.);
        ignore (Unix.nanosleep 0.01 : float)
      done;
      Servo.set_direction Servo.sonar 0.5)

let () =
  Command.group
    ~summary:"Command for playing with the robot APIs"
    [ "sonic", sonic
    ; "sonic-scan", sonic_scan
    ; "servo", servo
    ; "blink", blink
    ; "buzzer", buzzer
    ; "forward", forward
    ]
  |> Command.run
