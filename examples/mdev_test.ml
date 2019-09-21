open Core
open Mdev

(*
  match cmd with
  | `blink ->
    Mdev.set_rgb mdev ~r:0 ~g:1 ~b:1;
    Unix.sleep 3;
    Mdev.set_rgb mdev ~r:1 ~g:0 ~b:1;
    Unix.sleep 3;
    Mdev.set_rgb mdev ~r:1 ~g:1 ~b:0;
    Unix.sleep 3;
    Mdev.set_rgb mdev ~r:1 ~g:1 ~b:1
  | `buzzer ->
    Mdev.set_buzzer mdev ~level:3000;
    Unix.sleep 1;
    Mdev.set_buzzer mdev ~level:0
  | `forward ->
    Mdev.set_pwm mdev ~level:1000;
    Unix.sleep 1;
    Mdev.set_pwm mdev ~level:0
*)

let sonic_scan =
  Command.basic
    ~summary:"Do a sonic scan while swinging the scanner back and forth"
    [%map_open.Command.Let_syntax
      let () = return () in
      fun () ->
        Led.set_rgb false true true;
        for d = 0 to 100 do
          Servo.set_direction Servo.sonar (float_of_int d /. 100.);
          let sonic = Sonic.get_distance () in
          Printf.printf "%2d %f\n%!" d sonic;
          ignore (Unix.nanosleep 0.01 : float)
        done;
        Servo.set_direction Servo.sonar 0.5;
        Led.set_rgb true true true
    ]


let sonic =
  Command.basic
    ~summary:"Grab a bunch of measurements from the sonic sensor"
    [%map_open.Command.Let_syntax
      let () = return () in
      fun () ->
        for d = 0 to 25 do
          let sonic = Mdev.Sonic.get_distance () in
          Printf.printf "%2d %f\n%!" d sonic;
          ignore (Unix.nanosleep 0.04 : float)
        done]

let servo =
  Command.basic
    ~summary:"Exercise the sonic servo"
    [%map_open.Command.Let_syntax
      let () = return () in
      fun () ->
        for d = 0 to 100 do
          Servo.set_direction Servo.sonar (float_of_int d /. 100.);
          ignore (Unix.nanosleep 0.01 : float)
    done;
    Servo.set_direction Servo.sonar 0.5
    ]

let () =
  Command.group
    ~summary:"Command for playing with the robot APIs"
    [ "sonic", sonic
    ; "sonic-scan", sonic_scan
    ; "servoe", servo
    ]
  |> Command.run
