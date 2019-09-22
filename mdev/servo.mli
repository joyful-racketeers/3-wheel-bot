open! Base
open! Import

type t

val sonar : t
val steering : t

(** Direction is a number between -1 and 1, where -1 is all the way to
   the left and 1 is all the way to the right.  *)
val set_direction : t -> float -> unit

(** Adjust the upper and lower bounds between which the sensors will
   try to go.  Mostly useful for tuning the bot *)
val set_bounds : t -> lo:float -> hi:float -> unit
