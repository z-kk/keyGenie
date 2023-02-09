import
  std / [os, strutils],
  docopt,
  version

type
  cmdOpt* = object
    target*: string

let
  appName* = getAppFilename().extractFilename

proc readCmdOpt*(): cmdOpt =
  ## Read command line options.
  let doc = """
    $1

    Usage:
      $1 [<target>]

    Options:
      -h --help     Show this screen.
      -v --version  Show version.
      <target>      Target key name.
  """ % [appName]
  let args = doc.dedent.docopt(version = Version)
  if args["<target>"]:
    result.target = $args["<target>"]
