open Core
open Import

let run () =
  let rec loop () =
    Led.set_rgb false false true;
    Unix.sleep 1;
    Led.set_rgb true false false;
    Unix.sleep 1;
    Led.set_rgb false true true;
    Unix.sleep 1;
    Led.set_rgb true false true;
    Unix.sleep 1;
    loop ()
  in
  loop ()

let command = no_arg_command "Blink the LED" run
