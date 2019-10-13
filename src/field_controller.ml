open! Core
open! Import

let run () =
  Scan.run
    ~num_steps:30
    ~delay:(Time.Span.of_ms 10.)
    ~scan_completed:(fun _scan ->
        (* Figure out what to do with the scan here! *)
        ())

let command = no_arg_async_command "Drive with a field controller" run
