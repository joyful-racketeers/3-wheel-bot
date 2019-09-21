open! Base
open! Import

type t

val left_motor : t
val right_motor : t

(** Set the speed of the motor; positive values go forward, negative
   values go backwards.  *)
val set_speed : t -> int -> unit
