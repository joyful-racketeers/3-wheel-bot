open! Base
open! Import

val set_port : Port.t -> unit
val write : Port.t -> Uint16.t -> unit
val read_data : Port.t -> Uint8.t
