open! Core
open! Import

let command =
  Command.group
    ~summary:"Command for playing with the robot APIs"
    [ "sonic-sense", Sonic_sense.command
    ; "sonic-scan", Sonic_scan.command
    ; "servo-spin", Servo_spin.command
    ; "blink", Blink.command
    ; "buzz", Buzz.command
    ; "forward", Forward.command
    ; "stop", Stop.command
    ; "field-controller", Field_controller.command
    ]
