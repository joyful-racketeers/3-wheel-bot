open Import

type t =
  | Forward
  | Reverse

let to_int direction =
  match direction with
  | Forward -> Uint16.one
  | Reverse -> Uint16.zero
