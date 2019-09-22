(** This library contains modules for interacting with specific
   modules on the 3-wheeled Freenove robot car.  The robot is treated
   as a globally available resources, though the connection isn't
   actually initialized until you try to do something with one of the
   interfaces. *)

module Buzzer = Buzzer
module Direction = Direction
module Led = Led
module Motor = Motor
module Servo = Servo
module Sonic = Sonic
