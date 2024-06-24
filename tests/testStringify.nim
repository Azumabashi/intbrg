
import unittest

import intbrg

suite "Stringify":
  test "formula":
    const x = "11000011"
    check(x == $(toFormulae(x)))
  
  test "model":
    const m = "000"
    check(m == $(toModel(m)))