open Smbus

module Glob = Global_variables

let set_port (port : Port.t) =
  Bus.write_byte Glob.bus port.num
            
let write port v =
  set_port port;
  Bus.write_block_data2 Glob.bus port.num v
let read_data port =
  set_port port;
  Bus.read_byte_data Glob.bus port.num
