open! Core
open! Async
open! Import

let run () =
  Servo.set_direction Servo.steering 0.;
  (* Run forever, stopping the motor if too close to an obstacle. *)
  every (Time.Span.of_sec 0.05) (fun () ->
      let too_close =
        let measurement = Sonic.get_distance_robust () in
        measurement < 50.
      in
      if too_close
      then Led.set_rgb true false false
      else Led.set_rgb false true false;
      let speed = 2000 in
      if too_close then (
        Motor.set_speed Motor.left speed;
        Motor.set_speed Motor.right (-speed))
      else (
        Motor.set_speed Motor.left speed;
        Motor.set_speed Motor.right speed));
  Deferred.never ()

let command = no_arg_async_command "Move the robot forward" run
