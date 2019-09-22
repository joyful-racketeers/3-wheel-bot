open! Core
open! Import

let run () =
  Servo.set_direction Servo.steering 0.;
  Motor.set_speed Motor.left 1000;
  Motor.set_speed Motor.right 1000;
  Unix.sleep 1;
  Motor.set_speed Motor.left 0;
  Motor.set_speed Motor.right 0

let command = no_arg_command "Move the robot forward" run
