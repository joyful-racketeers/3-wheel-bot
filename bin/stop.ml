open! Core
open! Async
open! Import

let run () =
  Motor.set_speed Motor.left 0;
  Motor.set_speed Motor.right 0;
  Deferred.never ()

let command = no_arg_async_command "Stop the motors" run
