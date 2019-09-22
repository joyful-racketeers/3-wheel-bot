open! Base
open! Import

let high_port = Port.sonic1
let low_port = Port.sonic2

let get_distance () =
  let high_reading = Std_bus.read_data high_port in
  let low_reading = Std_bus.read_data low_port in
  Float.of_int ((Uint8.to_int high_reading * 256) + Uint8.to_int low_reading)
  *. 17.
  /. 1000.

let get_distance_robust () =
  List.init 5 ~f:(fun _ -> get_distance ())
  |> List.reduce_exn ~f:Float.min
