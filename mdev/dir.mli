open! Import

type t

val create : Port.t -> t
val port : t -> Port.t

type direction =
  | Forward
  | Reverse

val set_dir : t -> direction -> unit
