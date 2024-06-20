import strutils

type Formulae* = distinct uint64 | distinct uint32 | distinct uint16 | distinct uint8

# Logical operators
proc `and`*(x, y: Formulae): Formulae = x and y
proc `or`*(x, y: Formulae): Formulae = x or y
proc `not`*(x: Formulae): Formulae = not x
proc `implies`*(left, right: Formulae): Formulae = (not left) or right

# equivalence
proc `equiv`*(x, y: Formulae): bool = x == y
proc `==`*(x, y: Formulae): bool = x equiv y

# bit width
func getBitWidth*(x: Formulae): int = 8 * sizeof type x

# stringify
proc `$`*(x: Formulae): string = toBin(x, getBitWidth(x))

# convert to formulae
func toFormulae*(bit: string): Formulae =
  assert bin.len in @[8, 16, 32, 64]
  parseBiggestUInt(bit).Formulae
