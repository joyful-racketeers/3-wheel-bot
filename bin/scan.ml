open! Core
open! Async
open! Import

type scan_direction =
  | Left
  | Right

let flip = function
  | Left -> Right
  | Right -> Left

type state =
  { direction : scan_direction
  ; scan : float list
  ; step : int
  }

let run ~scan_completed ~num_steps =
  let loop_delay = Time.Span.of_sec 0.01 in
  let rec loop state =
    let percent_through = Float.of_int state.step /. Float.of_int num_steps in
    let normalized_direction = (2. *. percent_through) -. 1. in
    let sonar_direction =
      match state.direction with
      | Right -> normalized_direction
      | Left -> -.normalized_direction
    in
    Servo.set_direction Servo.sonar sonar_direction;
    let%bind () = after loop_delay in
    let distance = Sonic.get_distance_robust () in
    let scan = distance :: state.scan in
    let next_step = state.step + 1 in
    if next_step <= num_steps
    then loop { state with step = next_step; scan }
    else (
      (* End of the scan! *)
      scan_completed
        (match state.direction with
        | Right -> scan
        | Left -> List.rev scan);
      loop { step = 0; direction = flip state.direction; scan = [] })
  in
  loop { direction = Right; scan = []; step = 0 }
