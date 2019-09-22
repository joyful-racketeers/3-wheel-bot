open! Core
open! Async
open! Import

let until_close ~how_close ~gap_between_measurements =
  let rec loop () =
    let measurement = Sonic.get_distance () in
    if measurement > how_close
    then (
      let%bind () = Clock.after gap_between_measurements in
      loop ())
    else return ()
  in
  loop ()

let run () =
  Servo.set_direction Servo.steering 0.;
  Motor.set_speed Motor.left 200;
  Motor.set_speed Motor.right 200;
  let%bind () =
    until_close
      ~how_close:100.
      ~gap_between_measurements:(Time.Span.of_sec 0.05)
  in
  Motor.set_speed Motor.left 0;
  Motor.set_speed Motor.right 0;
  return ()

let command = no_arg_async_command "Move the robot forward" run
