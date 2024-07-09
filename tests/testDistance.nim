import unittest

import intbrg

suite "Distance functions":
  let m1 = toModel("10100101")
  let m2 = toModel("11110000")
  let m3 = toModel("10100101")

  test "drastic":
    check(drastic(m1, m2) == 1)
    check(drastic(m1, m3) == 0)
  
  test "hamming":
    check(hamming(m1, m2) == 4)
    check(hamming(m1, m3) == 0)