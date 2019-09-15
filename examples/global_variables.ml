open Smbus
   
let bus =
  let bus = Bus.create 1 in
  Bus.set_address bus (Uint8.of_int_exn 0x18) ~force:false;
  bus
