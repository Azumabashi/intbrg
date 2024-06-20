import formulae
import sequtils
import strutils

type Model* = distinct uint

# test whether two models are the same or not
func `==`*(x, y: Model): bool = x == y

# stringify
func `$`*(x: Model): string = toBin(x.int, 8)

func getModels*(f: Formulae): seq[Model] =
  ## Returns the set of f's models.
  let size = f.digits
  let str = $f
  return (0..<size).toSeq.filterIt(str[it] == '1').mapIt(it.Model)

# SAT-related functions
func isSat*(f: Formulae): bool = f.getModels.len > 0
func isUnsat*(f: Formulae): bool = not isSat(f)
func isTautology*(f: Formulae): bool = f.getModels.len == f.digits