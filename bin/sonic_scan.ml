open! Core
open! Async
open! Import

let run ~num_steps ~delay =
  Scan.run ~num_steps ~delay ~scan_completed:(fun full_scan ->
      let scan = List.map ~f:snd full_scan in
      let avg =
        List.sum ~f:Fn.id (module Float) scan
        /. Float.of_int (List.length scan)
      in
      let min = List.reduce_exn ~f:Float.min scan in
      let max = List.reduce_exn ~f:Float.max scan in
      print_s
        [%message
          "results"
            (avg : Float.Terse.t)
            (min : Float.Terse.t)
            (max : Float.Terse.t)
            (full_scan : (Float.Terse.t * Float.Terse.t) list)])

let command =
  Command.async
    ~summary:"Do a sonic scan while swinging the scanner back and forth"
    [%map_open.Command.Let_syntax
      let num_steps =
        flag
          "-steps"
          (optional_with_default 25 int)
          ~doc:" Number of steps in scan"
      and delay =
        flag
          "-delay"
          (optional_with_default (Time.Span.of_ms 10.) Time.Span.arg_type)
          ~doc:" Time span between turn and measurement"
      in
      fun () -> run ~num_steps ~delay]
