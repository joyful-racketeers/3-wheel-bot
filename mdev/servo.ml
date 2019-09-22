open! Base
open! Import

type t = { port : Port.t
         ; mutable lo : float
         ; mutable hi : float
         }

let create port ~lo ~hi = { port; lo; hi }

let set_bounds t ~lo ~hi =
  t.lo <- lo;
  t.hi <- hi

(** [interp ~lo ~hi x] is [lo] when [x] is [-1] and [hi] when [x] is
   [1] *)
let interp ~lo ~hi x =
  let x = 0.5 +. x *. 0.5 in
  lo +. (hi -. lo) *. x

let set_direction t v =
  if Float.(v < -1. || v > 1.)
  then raise_s [%message "v should be between 0 and 1" (v : float)];
  let v = interp ~lo:t.lo ~hi:t.hi v in
  Std_bus.write t.port
    (Float.iround_nearest_exn v |> Uint16.of_int_exn)

let sonar = create Port_map.sonar_servo ~lo:500. ~hi:2500.
let steering = create Port_map.steering_servo ~lo:0. ~hi:2000.
