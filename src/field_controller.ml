open! Core
open! Import

let rec largest_direction_helper list largest_so_far lsf_direction =
  match list with
  | [] -> lsf_direction
  | (direction, distance) :: rest ->
    if Float.( > ) distance largest_so_far
    then largest_direction_helper rest distance direction
    else largest_direction_helper rest largest_so_far lsf_direction

let largest_direction list =
  match list with
  | [] -> failwith "empty list!"
  | (direction, distance) :: rest ->
    largest_direction_helper rest distance direction

let run () =
  Scan.run
    ~num_steps:30
    ~delay:(Time.Span.of_ms 10.)
    ~scan_completed:(fun scan ->
      let dir = largest_direction scan in
      print_s [%sexp (scan : (Float.Terse.t * Float.Terse.t) list)];
      print_s [%sexp (dir : Float.Terse.t)];
      Servo.set_direction Servo.steering (-.dir)

(* Figure out what to do with the scan here! *)

let command = no_arg_async_command "Drive with a field controller" run
