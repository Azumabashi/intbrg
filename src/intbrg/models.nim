import formulae
import sequtils
import strutils

type Model* = distinct string

# test whether two models are the same or not
func `==`*(x, y: Model): bool {.borrow.}

# stringify
func `$`*(x: Model): string {.borrow.}

func toModel*(model: string): Model = model.Model

func getDigits(truthTableCols: int): int =
  var i = 0
  while (1 shl i) != truthTableCols:
    i += 1
  return i

func getModels*(f: Formulae): seq[Model] =
  ## Returns the set of f's models.
  let size = f.digits
  let str = $f
  let digits = getDigits(size)
  return (0..<size).toSeq
    .filterIt(str[it] == '1')
    .mapIt(toBin(size - it - 1, digits).Model)

func toIndex(model: Model): int =
  let maxIndex = (1 shl model.string.len) - 1
  return maxIndex - parseBinInt(model.string)

func toFormula*(ms: seq[Model]): Formulae =
  let idxs = ms.map(toIndex)
  var bottom = newSeqWith(1 shl ms[0].string.len, 0)
  for idx in idxs:
    bottom[idx] = 1
  return bottom.join("").toFormula

# SAT-related functions
func isSat*(f: Formulae): bool = f.getModels.len > 0
func isUnsat*(f: Formulae): bool = not isSat(f)
func isTautology*(f: Formulae): bool = f.getModels.len == f.digits