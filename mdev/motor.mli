open! Base
open! Import

type t

(** Creates a motor given a pwm and directional port.  Provide
   ~reverse:true if the motor is wired up backwards. *)
val create : reverse:bool -> pwm:Port.t -> dir:Port.t -> t

(** Set the speed of the motor; positive values go forward, negative
   values go backwards.  *)
val set_speed : t -> int -> unit
