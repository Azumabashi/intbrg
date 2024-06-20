import math
import algorithm

func sum*(xs: seq[int]): seq = xs.sum

func gMin*(xs: seq[int]): seq[int] = 
  var ys = xs
  ys.sort()
  return ys