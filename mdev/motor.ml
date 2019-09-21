open! Base
open! Import

type t =
  { pwm : Port.t
  ; dir : Port.t
  ; reverse : bool
  }

let create ~reverse ~pwm ~dir =
  Port.check_port_reqs
    [ Port.create_port_req pwm Port.Pwm
    ; Port.create_port_req dir Port.Dir ];
  { pwm; dir; reverse }

let set_speed t level =
  let level = if t.reverse then -level else level in
  let direction : Direction.t = if level > 0 then Forward else Reverse in
  Std_bus.write t.dir (Direction.to_int direction);
  Std_bus.write t.pwm (Uint16.of_int_exn (abs level))
