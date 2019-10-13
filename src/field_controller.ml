open! Core
open! Import

let rec smallest_distance_helper list smallest_so_far =
  match list with
  | [] -> smallest_so_far
  | (_, distance) :: rest ->
    let new_smallest_so_far = Float.min distance smallest_so_far in
    smallest_distance_helper rest new_smallest_so_far

let smallest_distance list =
  match list with
  | [] -> failwith "empty list!"
  | (_, distance) :: rest -> smallest_distance_helper rest distance

let run () =
  Scan.run
    ~num_steps:30
    ~delay:(Time.Span.of_ms 10.)
    ~scan_completed:(fun _scan ->
      (* Figure out what to do with the scan here! *)
      ())

let command = no_arg_async_command "Drive with a field controller" run
