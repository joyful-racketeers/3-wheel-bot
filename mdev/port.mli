open! Base
open! Import

type connection =
  | Servo
  | Pwm
  | Dir
  | Io
  | Buzzer
  | Sonic

type t =
  { num : Uint8.t
  ; connection : connection
  }

type port_req

val get_name : t -> string
val create_port_req : t -> connection -> port_req
val check_port_req : port_req -> unit
val check_port_reqs : ?all_dif:bool -> port_req list -> unit

(** {2 List of available ports} *)

val servo1 : t
val servo2 : t
val servo3 : t
val servo4 : t
val pwm1 : t
val pwm2 : t
val dir1 : t
val dir2 : t
val buzzer : t
val io1 : t
val io2 : t
val io3 : t
val sonic1 : t
val sonic2 : t
