import formulae
import models
import sequtils

type DistanceFunc* = proc (x, y: Model): int
type AggregateFunc*[T] = proc (xs: seq[int]): T

proc d(omega: Model, phi: Formulae, dist: DistanceFunc): int = 
  phi.getModels().mapIt(dist(it, omega)).min()

proc df[T](omega: Model, ks: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): T =
  ks.mapIt(d(omega, it, dist)).aggr()

func `<`*(xs, ys: seq[int]): bool =
  for (x, y) in zip(xs, ys):
    if x > y:
      return false
    elif x < y:
      return true
    else:
      discard
  
  # in case of xs == ys
  return false

func `<=`*(xs, ys: seq[int]): bool = 
  xs == ys or xs < ys

proc delta*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  let models = self.getModels()
  let dfs = models.mapIt(df(it, others, dist, aggr))
  let minDfs = dfs.min()
  let newModels = (0..<models.len).toSeq.filterIt(dfs[it] == minDfs).mapIt(models[it])
  return newModels.toFormula

# R1 to R6
proc r1*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  delta(getTautology(self.digits), others, dist, aggr)

proc r2*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  let d = r1(self, others, dist, aggr)
  delta(d, @[self], dist, aggr)

proc r3*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  delta(getTautology(self.digits), @[self].concat(others), dist, aggr)

proc r4*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  delta(getTautology(self.digits), @[self, r1(self, others, dist, aggr)], dist, aggr)

proc r5*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  delta(self, @[r1(self, others, dist, aggr)], dist, aggr)

proc r6*[T](self: Formulae, others: seq[Formulae], dist: DistanceFunc, aggr: AggregateFunc[T]): Formulae =
  delta(self, others, dist, aggr)