import unittest

import intbrg

suite "Test revision operators":
  const alice = toFormula("00001100")
  const bob = toFormula("10110000")
  const charles = toFormula("00001111")

  test "R1":
    proc R1(self: Formulae, others: seq[Formulae]): Formulae = 
      r1(self, others, hamming, sum)
    
    # Alice
    check(R1(alice, @[bob]) == toFormula("10110000"))
    # Bob
    check(R1(bob, @[alice, charles]) == toFormula("00001100"))
    # Charles
    check(R1(charles, @[bob]) == toFormula("10110000"))
  
  test "R2":
    proc R2(self: Formulae, others: seq[Formulae]): Formulae =
      r2(self, others, hamming, sum)
    
    # Alice
    check(R2(alice, @[bob]) == toFormula("10000000"))
    # Bob
    check(R2(bob, @[alice, charles]) == toFormula("00001000"))
    # Charles
    check(R2(charles, @[bob]) == toFormula("10110000"))

  # test "R3":
  #   # see testTable2.nim

  test "R4":
    proc R4(self: Formulae, others: seq[Formulae]): Formulae =
      r4(self, others, hamming, sum)
    
    # Alice
    check(R4(alice, @[bob]) == toFormula("10001000"))
    # Bob
    check(R4(bob, @[alice, charles]) == toFormula("10001000"))
    # Charles
    check(R4(charles, @[bob]) == toFormula("10111011"))

  test "R5":
    proc R5(self: Formulae, others: seq[Formulae]): Formulae =
      r5(self, others, hamming, sum)
    
    # Alice
    check(R5(alice, @[bob]) == toFormula("00001000"))
    # Bob
    check(R5(bob, @[alice, charles]) == toFormula("10000000"))
    # Charles
    check(R5(charles, @[bob]) == toFormula("00001011"))

  test "R6":
    proc R6(self: Formulae, others: seq[Formulae]): Formulae =
      r6(self, others, hamming, sum)
    
    # Alice
    check(R6(alice, @[bob]) == toFormula("00001000"))
    # Bob
    check(R6(bob, @[alice, charles]) == toFormula("10000000"))
    # Charles
    check(R6(charles, @[bob]) == toFormula("00001011"))