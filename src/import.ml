open Core
include Mdev

let no_arg_command summary f = Command.basic ~summary (Command.Param.return f)

let no_arg_async_command summary f =
  Async.Command.async ~summary (Command.Param.return f)
