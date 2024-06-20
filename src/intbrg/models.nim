import formulae
import sequtils

func getModels*(f: Formulae): seq[int] =
  ## Returns the set of f's models.
  let size = 8 * sizeof(typeof(f))
  let str = $f
  return (0..<size).filterIt(str[i] == '1')