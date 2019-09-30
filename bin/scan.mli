open! Core
open! Async
open! Import

(** Start a process which will scan back and forth indefinitely  *)
val run
  :  scan_completed:(float list -> unit)
  -> steps:int
  -> robust:bool
  -> unit Deferred.t
