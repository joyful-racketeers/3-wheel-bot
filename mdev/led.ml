open Smbus

type t = { red_port   : Port.t
          ;green_port : Port.t
          ;blue_port  : Port.t}

let create red_port green_port blue_port =
  Port.check_port_reqs
    [Port.create_port_req red_port   Port.Io
    ;Port.create_port_req green_port Port.Io
    ;Port.create_port_req blue_port  Port.Io];
  {red_port; green_port; blue_port}
  
let red_port   t = t.red_port
let green_port t = t.green_port
let blue_port  t = t.blue_port
       
let set_io port on =
  Std_bus.write port (if on then Uint16.one else Uint16.zero)

let set_color t r_on g_on b_on =
  set_io t.red_port   r_on;
  set_io t.green_port g_on;
  set_io t.blue_port  b_on
