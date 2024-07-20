import unittest
import sequtils

import intbrg

suite "iterator allFormulae":
  test "bit width":
    check("1111".toFormula.getBitWidth == 4)
  
  test "allFormulae":
    check(
      allFormulae(2).toSeq == 
      @[
        "0000", "0001", "0010", "0011",
        "0100", "0101", "0110", "0111",
        "1000", "1001", "1010", "1011",
        "1100", "1101", "1110", "1111",
      ].map(toFormula)
    )