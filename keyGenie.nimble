# Package

version       = "0.1.0"
author        = "z-kk"
description   = "Handle strings through encryption."
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["keyGenie"]
binDir        = "bin"


# Dependencies

requires "nim >= 1.6.0"


# Tasks

task r, "build and run":
  exec "nimble build"
  exec "nimble ex"

import std / os
task ex, "run without build":
  withDir binDir:
    exec "." / bin[0]
