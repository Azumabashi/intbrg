import formulae
import sequtils

func getModels*(f: Formulae): seq[int] =
  ## Returns the set of f's models.
  let size = 8 * sizeof(typeof(f))
  let str = $f
  return (0..<size).filterIt(str[i] == '1')

# SAT-related functions
func isSat*(f: Formulae): bool = f.getModels.len > 0
func isUnsat*(f: Formulae): bool = not isSat(f)
func isTautology*(f: Formulae): bool = f.getModels.len == 8 * sizeof(typeof(f))