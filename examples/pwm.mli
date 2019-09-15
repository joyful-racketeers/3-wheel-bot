type t

val create : ?reverse:bool -> Port.t -> Port.t -> t
val port : t -> Port.t
val dir : t -> Dir.t
val reverse : t -> bool

val set_pwm : t -> int -> unit
                                               
