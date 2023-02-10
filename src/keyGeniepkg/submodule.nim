import
  std / [os, strutils],
  docopt,
  version

type
  cmdOpt* = object
    isOneLine*: bool
    target*: string
    passwd*: string

let
  appName* = getAppFilename().extractFilename

proc readCmdOpt*(): cmdOpt =
  ## Read command line options.
  let doc = """
    $1

    Usage:
      $1 [<target>] [-p <password>]
      $1 <target> -p <password> -n

    Options:
      -h --help     Show this screen.
      -v --version  Show version.
      -n            Don't make newline.
      <target>      Target key name.
      <password>    Password.
  """ % [appName]
  let args = doc.dedent.docopt(version = Version)
  result.isOneLine = args["-n"]
  if args["<target>"]:
    result.target = $args["<target>"]
  if args["<password>"]:
    result.passwd = $args["<password>"]
