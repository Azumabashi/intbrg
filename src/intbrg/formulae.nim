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

# stringify
proc `$`*(x: Formulae): string = toBin(x, sizeof(type(x)))
