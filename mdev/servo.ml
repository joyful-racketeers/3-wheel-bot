open! Base
open! Import

type t = { port : Port.t }

let create port = { port }

let set_direction t v =
  if Float.(v < 0. || v > 1.)
  then raise_s [%message "v should be between 0 and 1" (v : float)];
  (* The value has to be between 500 and 2500. *)
  let v = 500. +. (2000. *. v) in
  Std_bus.write t.port (Float.to_int v |> Uint16.of_int_exn)

let sonar = create Port_map.sonar_servo
let steering = create Port_map.steering_servo
