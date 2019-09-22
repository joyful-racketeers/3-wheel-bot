open! Base
open! Import

(** Each read takes about 2ms.  They're not especially reliable,
   though.  See the robust read code. *)
val get_distance : unit -> float

(** Does multiple reads and combines them together to get a single
   more reliable read.  Does 5 reads, so takes about 10ms. *)
val get_distance_robust : unit -> float
