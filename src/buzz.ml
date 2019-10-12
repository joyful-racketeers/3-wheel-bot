open Core
open Import

let run () =
  Buzzer.set_level 3000;
  Unix.sleep 1;
  Buzzer.set_level 0

let command = no_arg_command "Make some noise!" run
