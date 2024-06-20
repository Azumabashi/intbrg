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

# R1 to R6
func r1*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  delta(getTautology(self.digits), others, dist, aggr)

func r2*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  let d = r1(self, others, dist, aggr)
  delta(d, @[self], dist, aggr)

func r3*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  delta(getTautology(self.digits), @[self] + others, dist, aggr)

func r4*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  delta(getTautology(self.digits), @[self, r1(self, others, dist, aggr)], dist, aggr)

func r5*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  delta(self, r1(self, others, dist, aggr), dist, aggr)

func r6*(self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc): Formulae =
  delta(self, others, dist, aggr)