open Import

type t =
  { red_port : Port.t
  ; green_port : Port.t
  ; blue_port : Port.t
  }

let t =
  let red_port = Port_map.io1 in
  let green_port = Port_map.io2 in
  let blue_port = Port_map.io3 in
  Port.check_port_reqs
    [ Port.create_port_req red_port Io
    ; Port.create_port_req green_port Io
    ; Port.create_port_req blue_port Io
    ];
  { red_port; green_port; blue_port }

let set_io port on =
  Std_bus.write port (if on then Uint16.zero else Uint16.one)

let set_rgb r_on g_on b_on =
  set_io t.red_port r_on;
  set_io t.green_port g_on;
  set_io t.blue_port b_on
