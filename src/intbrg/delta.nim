import formulae
import models
import sequtils
import strutils

type DistanceFunc* = proc (x, y: Model): int
type AggregateFunc*[T: int | seq[int]] = proc (xs: seq[int]): T

proc d(omega: Model, phi: Formulae, dist: DistanceFunc): int = 
  phi.getModels().mapIt(dist(it, omega)).min()

func df[T](omega: Model, ks: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): T =
  ks.mapIt(d(omega, it, dist)).aggr()

func delta*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  let models = self.getModels()
  let dfs = models.mapIt(df(it, others, dist, aggr))
  let minDfs = dfs.min()
  let newModels = (0..<models.len).toSeq.filterIt(dfs[it] == minDfs)
  let truthTable = newSeqWith(0, getBitWidth(self))
  for m in newModels:
    truthTable[m] = 1
  return truthTable.join("").parseBinInt().Formulae