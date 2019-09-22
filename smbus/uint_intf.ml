(** Module containing a signature for specialized unisgned integer
   types *)

module type S = sig
  type t = private int

  val zero : t
  val one : t
  val of_int_exn : int -> t
  val to_int : t -> int
end
