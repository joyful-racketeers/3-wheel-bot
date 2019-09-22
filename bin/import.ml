open Core
include Mdev

let no_arg_command summary f = Command.basic ~summary (Command.Param.return f)
