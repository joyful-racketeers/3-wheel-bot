open! Base
open! Import

type t =
  { port : Port.t
  ; dir : Dir.t
  ; reverse : bool
  }

let create ?(reverse = false) pwm_port dir_port =
  Port.check_port_reqs
    [ Port.create_port_req pwm_port Port.Pwm; Port.create_port_req dir_port Port.Dir ];
  { port = pwm_port; dir = Dir.create dir_port; reverse }

let port t = t.port
let dir t = t.dir
let reverse t = t.reverse

let set_pwm t level =
  let level = if t.reverse then -level else level in
  if level < 0 then Dir.set_dir t.dir Dir.Reverse else Dir.set_dir t.dir Dir.Forward;
  Std_bus.write t.port (Uint16.of_int_exn (abs level))
