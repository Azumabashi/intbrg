import bigints
import algorithm
import strutils

type Formulae* = tuple
  formula: BigInt
  digits: int

# Logical operators
proc `and`*(x, y: Formulae): Formulae = (x.formula and y.formula, x.digits)
proc `or`*(x, y: Formulae): Formulae = (x.formula or y.formula, x.digits)
proc `not`*(x: Formulae): Formulae = (initBigInt(repeat("1", x.digits), 2) - x.formula, x.digits)
proc `implies`*(left, right: Formulae): Formulae = (not left) or right

# equivalence
proc `==`*(x, y: Formulae): bool = x.formula == y.formula and x.digits == y.digits
proc `equiv`*(x, y: Formulae): bool = x == y

# bit width
func getBitWidth*(x: Formulae): int = x.digits

# stringify
proc `$`*(x: Formulae): string = 
  var digits: seq[int] = @[]
  for i in 0..<x.digits:
    let isPop = ((x.formula shr i) and initBigInt(1)) > initBigInt(0)
    digits.add(if isPop: 1 else: 0)
  digits.reversed.join("")

# convert to formula
func toFormula*(bit: string): Formulae = (initBigInt(bit, 2), bit.len)

func getTautology*(width: int): Formulae = 
  (initBigInt("1".repeat(width), 2), width)

# Iterate all formulae
iterator allFormulae*(propositions: int): Formulae =
  let possibleModels = 1 shl propositions
  let possibleModelSets = 1 shl possibleModels
  for index in 0..<possibleModelSets:
    yield toBin(index, possibleModels).toFormula()