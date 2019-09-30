open! Core
open! Async
open! Import

let run () =
  Scan.run ~steps:100 ~scan_completed:(fun scan ->
      print_s [%sexp (scan : float list)])

let command =
  no_arg_async_command
    "Do a sonic scan while swinging the scanner back and forth"
    run
