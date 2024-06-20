import math
import algorithm

func sum*(xs: seq[int]): int = math.sum(xs)

func gMin*(xs: seq[int]): seq[int] = 
  var ys = xs
  ys.sort()
  return ys