type t

val create : Port.t -> Port.t -> Port.t -> t

val red_port   : t -> Port.t
val green_port : t -> Port.t
val blue_port  : t -> Port.t

val set_color : t -> bool -> bool -> bool -> unit
