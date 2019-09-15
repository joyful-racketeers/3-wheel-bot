open Smbus

type t = {high_port : Port.t
         ;low_port  : Port.t}

let create high_port low_port = {high_port; low_port}
let high_port t = t.high_port
let low_port  t = t.low_port

let get_distance t =
  let high_reading = Std_bus.read_data t.high_port in
  let low_reading  = Std_bus.read_data t.low_port  in
  float_of_int ((Uint8.to_int high_reading * 256) + Uint8.to_int low_reading)
  *. 17. /. 1000.
