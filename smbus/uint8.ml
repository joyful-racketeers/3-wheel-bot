type t = int

let of_int_exn int =
  if int < 0 || int > 255
  then (
    let msg = Printf.sprintf "out of bounds %d" int in
    raise (Invalid_argument msg));
  int

let to_int t = t
let zero = 0
let one = 1
