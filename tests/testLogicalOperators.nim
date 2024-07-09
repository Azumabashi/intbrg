
import unittest

import intbrg

suite "Logical Operators":
  test "and":
    const phi =      toFormulae("11001100")
    const psi =      toFormulae("11110000")
    const expected = toFormulae("11000000")
    check((phi and psi) == expected)
  
  test "or":
    const phi =      toFormulae("11001100")
    const psi =      toFormulae("11110000")
    const expected = toFormulae("11111100")
    check((phi or psi) == expected)
  
  test "not":
    const phi =      toFormulae("11100011")
    const expected = toFormulae("00011100")
    check((not phi) == expected)
  
  test "implies":
    const phi =      toFormulae("11110000")
    const psi =      toFormulae("11001100")
    const expected = toFormulae("11001111")
    check(implies(phi, psi) == expected)