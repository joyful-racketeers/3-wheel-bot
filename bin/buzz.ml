open Core
open Import

let command =
  no_arg_command "Make some noise!" (fun () ->
      Buzzer.set_level 3000;
      Unix.sleep 1;
      Buzzer.set_level 0)
