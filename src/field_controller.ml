open! Core
open! Import

let average_dir list =
  let list = List.map list ~f:(fun (x,y) -> (x, 1. /. y)) in
  let weight =
    List.map ~f:snd list
    |> List.sum (module Float) ~f:Fn.id
  in
  let sumproduct =
    List.map ~f:(fun (x,y) -> x *. y) list
    |> List.sum (module Float) ~f:Fn.id
  in
  sumproduct /. weight

let run () =
  Scan.run
    ~num_steps:30
    ~delay:(Time.Span.of_ms 10.)
    ~scan_completed:(fun scan ->
      let dir = average_dir scan in
      print_s [%sexp (scan : (Float.Terse.t * Float.Terse.t) list)];
      print_s [%sexp (dir : Float.Terse.t)];
      Servo.set_direction Servo.steering (-.dir))

(* Figure out what to do with the scan here! *)

let command = no_arg_async_command "Drive with a field controller" run
