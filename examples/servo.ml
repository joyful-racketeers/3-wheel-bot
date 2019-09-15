open Smbus

type t = {port : Port.t}

let create port = {port}
let port_of t = t.port
       
let set t v =
  if v < 0. || v > 1. then raise (Invalid_argument "v has to be between 0 and 1");
  (* The value has to be between 500 and 2500. *)
  let v = 500. +. (2000. *. v) in
  Std_bus.write t.port (int_of_float v |> Uint16.of_int_exn)
