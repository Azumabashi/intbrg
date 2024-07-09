
import unittest
import sequtils

import intbrg

suite "Satisfiability and Models":
  test "gets correct models":
    const phi = toFormula("10101010")
    const expected = @["111", "101", "011", "001"].map(toModel)
    check(phi.getModels == expected)
  
  test "tautology detection":
    const phi = toFormula("11111111")
    check(phi.isTautology)
  
  test "SAT detection":
    const phi = toFormula("00000001")
    check(phi.isSat)