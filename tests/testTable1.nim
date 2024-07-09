import unittest

import intbrg

suite "Table 1":
  const mu = toFormulae("1110")
  const k1 = toFormulae("1000")
  const k2 = toFormulae("0001")
  const k3 = toFormulae("0001")
  const profile = @[k1, k2, k3]

  test "sum and hamming":
    check(delta(mu, profile, hamming, sum) == toFormulae("0110"))
  
  test "gmin and hamming":
    check(delta(mu, profile, hamming, gMin) == toFormulae("1000"))
  
  test "<= in lex over seq[int]":
    check(@[1, 1, 1] > @[0, 2, 2])
    check(not(@[0, 2, 2] > @[1, 1, 1]))
    check(@[1, 1, 1] >= @[0, 2, 2])
    check(@[1, 1, 1] >= @[1, 1, 1])
    check(not(@[0, 2, 2] >= @[1, 1, 1]))