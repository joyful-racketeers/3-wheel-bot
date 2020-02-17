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

let run ~speed ~steps ~delay =
  Motor.set_speed Motor.left speed;
  Motor.set_speed Motor.right speed;
  Scan.run
    ~num_steps:steps
    ~delay:(Time.Span.of_ms delay)
    ~scan_completed:(fun scan ->
        let dir = average_dir scan in
        let dir =
          if Float.is_nan dir then 0.
          else Float.clamp_exn ~min:(-1.) ~max:(1.) (1.4 *. dir)
        in
        print_s [%sexp (scan : (Float.Terse.t * Float.Terse.t) list)];
        print_s [%sexp (dir : Float.Terse.t)];
        Servo.set_direction Servo.steering dir)

(* Figure out what to do with the scan here! *)

let command =
  Async.Command.async ~summary:"Drive with a field controller"
    [%map_open.Command
      let speed =
        flag "-speed" (optional_with_default 25 int)
          ~doc:" Speed to go forward"
      and steps =
        flag "-steps" (optional_with_default 30 int)
          ~doc:" Sampling steps"
      and delay =
        flag "-delay" (optional_with_default 10. float)
          ~doc:"milliseconds per sample"
      in
      fun () -> run ~speed ~steps ~delay]
