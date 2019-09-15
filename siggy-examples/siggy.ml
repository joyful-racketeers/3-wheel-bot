open! Base
open! Stdio

let x = 3
let f y = y + 10
let rec blurk x y = if y = x then y else x + blurk (x + 1) y

module M = struct
  type t =
    | Foo
    | Bar
end

type pig =
  { weight : float
  ; name : string
  ; alive : bool
  }

let kill_pig p = { p with alive = false }

