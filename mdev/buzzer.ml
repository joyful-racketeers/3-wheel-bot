open! Base
open! Import

let set_level x =
  Std_bus.write Port.buzzer (Uint16.of_int_exn x)
