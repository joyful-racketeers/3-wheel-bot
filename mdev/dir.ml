open Smbus

type t = {port : Port.t}

let create port = {port}
let port t = t.port

type direction =
  | Forward
  | Reverse

let direction_to_int direction =
  match direction with
  | Forward -> Uint16.one
  | Reverse -> Uint16.zero
  
let set_dir t direction =
  Std_bus.write t.port (direction_to_int direction)
