open! Core
open! Async
open! Import

let run () =
  Scan.run ~steps:25 ~robust:true ~scan_completed:(fun scan ->
      let avg = List.sum ~f:Fn.id (module Float) scan /. Float.of_int (List.length scan) in
      let min = List.reduce_exn ~f:Float.min scan in
      let max = List.reduce_exn ~f:Float.max scan in
      print_s [%message "results"
                  (avg : float)
                  (min : float)
                  (max : float)
                  (scan : float list)])

let command =
  no_arg_async_command
    "Do a sonic scan while swinging the scanner back and forth"
    run
