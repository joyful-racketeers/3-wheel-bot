(*val set_rgb : r:int -> g:int -> b:int -> unit
val set_buzzer : level:int -> unit
val set_pwm    : level:int -> unit

val get_sonic : float

(** [set_servo1 t v] sets servo 1 to orientation [v] between 0 and 1. *)

val set_differential_servo : float -> unit
val set_sonar_servo        : float -> unit
                                        (* val set_camera_servo       : float -> unit *)
 *)
