open! Core
open! Async
open! Import

let run () =
  Servo.set_direction Servo.steering 0.;
  (* Run forever, stopping the motor if too close to an obstacle. *)
  every (Time.Span.of_sec 0.05) (fun () ->
      let speed =
        let measurement = Sonic.get_distance_robust () in
        if measurement < 50. then 0 else 2000
      in
      Motor.set_speed Motor.left speed;
      Motor.set_speed Motor.right speed);
  Deferred.never ()

let command = no_arg_async_command "Move the robot forward" run
