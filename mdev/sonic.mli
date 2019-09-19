open! Base
open! Import

type t

val create : Port.t -> Port.t -> t
val high_port : t -> Port.t
val low_port : t -> Port.t
val get_distance : t -> float
