open! Base
open! Import

type t

val create : Port.t -> t
val port_of : t -> Port.t
val set : t -> float -> unit
