open! Core
open! Async
open! Import

let run () =
  Led.set_rgb true true true;
  let stop = Clock.after (Time.Span.of_sec 60.) in
  Clock.every (Time.Span.of_sec 0.04) ~stop (fun () ->
      let dist = Sonic.get_distance_robust () in
      if Float.(dist < 10.)
      then Led.set_rgb true false false
      else if Float.(dist < 100.)
      then Led.set_rgb false false true
      else if Float.(dist < 300.)
      then Led.set_rgb false true false
      else Led.set_rgb true true true);
  Clock.every (Time.Span.of_sec 0.5) ~stop (fun () ->
      let dist = Sonic.get_distance_robust () in
      printf "Distance: %F\n" dist);
  stop

let command =
  no_arg_async_command "Grab some measurements from the sonic sensor" run
