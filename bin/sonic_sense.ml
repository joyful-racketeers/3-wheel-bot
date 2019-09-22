open Core
open Import

let run () =
  for d = 0 to 1000 do
    let sonic = Mdev.Sonic.get_distance () in
    printf "%2d %f\n%!" d sonic;
    ignore (Unix.nanosleep 0.04 : float)
  done

let command = no_arg_command "Grab some measurements from the sonic sensor" run
