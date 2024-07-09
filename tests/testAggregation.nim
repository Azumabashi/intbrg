import unittest

import intbrg

suite "Aggregation functions":
  test "sum":
    check(sum(@[1, 2, 3]) == 1 + 2 + 3)
  
  test "GMin":
    check(gMin(@[5, 3, 2, 3, 1, 4, 5]) == @[1, 2, 3, 3, 4, 5, 5])