open! Base
open! Import

let bus =
  let bus = Bus.create 1 in
  Bus.set_address bus (Uint8.of_int_exn 0x18) ~force:false;
  bus

let set_port (port : Port.t) = Bus.write_byte bus port.num

let write port v =
  set_port port;
  Bus.write_block_data2 bus port.num v

let read_data port =
  set_port port;
  Bus.read_byte_data bus port.num
