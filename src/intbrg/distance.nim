import models
import sequtils

func drastic*(x, y: Model): int = 
  ## Drastic distance
  if x == y: 0 else: 1

func hamming*(x, y: Model): int =
  ## Hamming distance
  let sx = $x
  let sy = $y
  (0..<sx.len).toSeq.filterIt(sx[it] != sy[it]).len