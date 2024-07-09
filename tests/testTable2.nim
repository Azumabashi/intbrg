
import unittest

import intbrg

test "Table 2":
  const alice = toFormulae("00001100")
  const bob = toFormulae("10110000")
  const charles = toFormulae("00001111")
  
  proc revision(self: Formulae, others: seq[Formulae]): Formulae = 
    r3(self, others, hamming, sum)
  
  # 1st step
  const a1 = toFormulae("10001000")
  const b1 = toFormulae("00001000")
  const c1 = toFormulae("10111011")
  check(revision(alice, @[bob]) == a1)
  check(revision(bob, @[alice, charles]) == b1)
  check(revision(charles, @[bob]) == c1)

  # 2nd step
  const consensus = toFormulae("00001000")
  check(revision(a1, @[b1]) == consensus)
  check(revision(b1, @[a1, c1]) == consensus)
  check(revision(c1, @[b1]) == consensus)

  # 3rd step
  check(revision(consensus, @[consensus]) == consensus)
