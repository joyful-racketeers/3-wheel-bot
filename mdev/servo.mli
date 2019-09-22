open! Base
open! Import

type t

val sonar : t
val steering : t

(** Direction is a number between -1 and 1, where -1 is all the way to
   the left and 1 is all the way to the right.  *)
val set_direction : t -> float -> unit
