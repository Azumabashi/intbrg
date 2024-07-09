
import unittest

import intbrg

suite "Logical Operators":
  test "and":
    const phi =      toFormula("11001100")
    const psi =      toFormula("11110000")
    const expected = toFormula("11000000")
    check((phi and psi) == expected)
  
  test "or":
    const phi =      toFormula("11001100")
    const psi =      toFormula("11110000")
    const expected = toFormula("11111100")
    check((phi or psi) == expected)
  
  test "not":
    const phi =      toFormula("11100011")
    const expected = toFormula("00011100")
    check((not phi) == expected)
  
  test "implies":
    const phi =      toFormula("11110000")
    const psi =      toFormula("11001100")
    const expected = toFormula("11001111")
    check(implies(phi, psi) == expected)