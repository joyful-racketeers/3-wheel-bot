open! Core
open! Async
open! Import

type direction =
  | Left
  | Right

type mode =
  | Forward
  | Turning of direction

let run () =
  Servo.set_direction Servo.steering 0.;
  (* Run forever, stopping the motor if too close to an obstacle. *)
  let mode = ref Forward in
  every (Time.Span.of_sec 0.05) (fun () ->
      let too_close =
        let measurement = Sonic.get_distance_robust () in
        Float.(measurement < 50.)
      in
      (match !mode with
      | Turning _ -> if not too_close then mode := Forward
      | Forward ->
        if too_close
        then (
          let direction = if Random.bool () then Left else Right in
          mode := Turning direction));
      let speed = 2000 in
      match !mode with
      | Forward ->
        Led.set_rgb false true false;
        Motor.set_speed Motor.left speed;
        Motor.set_speed Motor.right speed
      | Turning dir ->
        Led.set_rgb true false false;
        let speed =
          match dir with
          | Left -> speed
          | Right -> -speed
        in
        Motor.set_speed Motor.left speed;
        Motor.set_speed Motor.right (-speed));
  Deferred.never ()

let command = no_arg_async_command "Move the robot forward" run
