import unittest

import keyGeniepkg/submodule
test "docopt":
  let opt = readCmdOpt()
  check opt.target == ""
