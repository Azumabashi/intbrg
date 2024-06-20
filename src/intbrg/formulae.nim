import bigints
import algorithm
import strutils

type Formulae* = distinct BigInt

# Logical operators
proc `and`*(x, y: Formulae): Formulae {.borrow.}
proc `or`*(x, y: Formulae): Formulae {.borrow.}
proc `not`*(x: Formulae): Formulae {.borrow.}
proc `implies`*(left, right: Formulae): Formulae = (not left) or right

# equivalence
proc `==`*(x, y: Formulae): bool {.borrow.}
proc `equiv`*(x, y: Formulae): bool = x == y

# bit width
proc fastLog2(x: Formulae): int {.borrow.}
func getBitWidth*(x: Formulae): int = fastLog2(x)

# stringify
proc `$`*(x: Formulae): string = 
  var digits: seq[int] = @[]
  for i in 0..<getBitWidth(x):
    let isPop = ((x.BigInt shr i) and initBigInt(1)) > initBigInt(0)
    digits.add(if isPop: 1 else: 0)
  digits.reversed.join("")

# convert to formulae
func toFormulae*(bit: string): Formulae =
  initBigInt(bit).Formulae
