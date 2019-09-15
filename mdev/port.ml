open Smbus
open Base

type connection =
  | Servo
  | Pwm
  | Dir
  | Io
  | Buzzer
  | Sonic
[@@deriving compare]

type t = { num: Uint8.t
         ; connection: connection
         }

let create num connection =
  let num = Uint8.of_int_exn num in
  { num; connection }

let to_string conn =
  match conn with
  | Servo -> "servo"
  | Pwm -> "pwm"
  | Dir -> "dir"
  | Io -> "io"
  | Buzzer -> "buzzer"
  | Sonic -> "sonic"

let get_name t =
  "connection: " ^ (to_string t.connection) ^
    ", port: " ^ (Int.to_string (Uint8.to_int t.num))
  
type port_req = {port : t; connection : connection}

let create_port_req port connection = {port; connection}
              
exception Bad_connection of string
exception Duplicate_port of string
                          
let check_port_req port_req =
  if (compare_connection port_req.port.connection port_req.connection) = 0
  then raise (Bad_connection
                ("Excpected a " ^ (to_string port_req.port.connection)
                 ^ "connection, but given a " ^ (to_string port_req.connection)
                ^ "connection."))
  
let check_port_reqs ?all_dif:(all_dif = true) port_reqs =
  if all_dif then
    let ports_used = Hash_set.create (module Int) in
    let full_check_port_req port_req =
      check_port_req port_req;
      let port_int = Uint8.to_int port_req.port.num in
      if Hash_set.mem ports_used port_int then
        raise (Duplicate_port
                 ("Attempted to assign multiple devices to port " ^
                    (Int.to_string port_int)))
      else Hash_set.add ports_used port_int
    in
    List.iter ~f:full_check_port_req port_reqs
      
  

let servo1 = create 0 Servo
let servo2 = create 1 Servo
let servo3 = create 2 Servo
let servo4 = create 3 Servo
let pwm1   = create 4 Pwm
let pwm2   = create 5 Pwm
let dir1   = create 6 Dir
let dir2   = create 7 Dir
let buzzer = create 8 Buzzer
let io1    = create 9 Io
let io2    = create 10 Io
let io3    = create 11 Io
let sonic1 = create 12 Sonic
let sonic2 = create 13 Sonic
         
