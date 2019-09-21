open Import

type t =
  | Forward
  | Reverse

val to_int : t -> Uint16.t
